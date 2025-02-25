# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/ProjectSakura/android.git -b 11 -g default,-mips,-darwin,-notdefault
git clone https://github.com/nikhil7011/local-manifests.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
export SAKURA_MAINTAINER=NuLL_Xception
source build/envsetup.sh
lunch lineage_RMX1851-userdebug
export TZ=Asia/Delhi #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
