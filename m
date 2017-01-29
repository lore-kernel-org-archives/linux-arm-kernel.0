From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 29 Jan 2017 10:11:17 +0800
Subject: [xlnx:master 2561/2699]
 drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:734:315:
 error: call to '__compiletime_assert_734' declared with attribute error:
 BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_post_notification_s),
 sizeof(u64))
Message-ID: <201701291004.rxfFVLOF%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   629041605b93343ad2e8971ceaac3edcef0b043b
commit: dadb5e41f28f9619debc9aae4ae543aa1dcd5be8 [2561/2699] staging: mali: r5p1-01rel0: Remove unused trace macros
config: i386-allyesconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout dadb5e41f28f9619debc9aae4ae543aa1dcd5be8
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c: In function 'mali_ioctl':
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:734:315: error: call to '__compiletime_assert_734' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_post_notification_s), sizeof(u64))
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_post_notification_s), sizeof(u64)));
                                                                                                                                                                                                                                                                                                                              ^                         
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:739:315: error: call to '__compiletime_assert_739' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_get_user_settings_s), sizeof(u64))
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_get_user_settings_s), sizeof(u64)));
                                                                                                                                                                                                                                                                                                                              ^                         
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:755:318: error: call to '__compiletime_assert_755' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_sw_counters_report_s), sizeof(u64))
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_sw_counters_report_s), sizeof(u64)));
                                                                                                                                                                                                                                                                                                                                 ^                         
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:761:342: error: call to '__compiletime_assert_761' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_profiling_memory_usage_get_s), sizeof(u64))
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_profiling_memory_usage_get_s), sizeof(u64)));
                                                                                                                                                                                                                                                                                                                                                         ^                         
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:782:288: error: call to '__compiletime_assert_782' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_free_mem_s), sizeof(u64))
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_free_mem_s), sizeof(u64)));
                                                                                                                                                                                                                                                                                                   ^                         
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:787:288: error: call to '__compiletime_assert_787' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_bind_mem_s), sizeof(u64))
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_bind_mem_s), sizeof(u64)));
                                                                                                                                                                                                                                                                                                   ^                         
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:797:306: error: call to '__compiletime_assert_797' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_mem_write_safe_s), sizeof(u64))
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_mem_write_safe_s), sizeof(u64)));
                                                                                                                                                                                                                                                                                                                     ^                         
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:802:354: error: call to '__compiletime_assert_802' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_query_mmu_page_table_dump_size_s), sizeof(u64))
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_query_mmu_page_table_dump_size_s), sizeof(u64)));
                                                                                                                                                                                                                                                                                                                                                                     ^                         
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:807:321: error: call to '__compiletime_assert_807' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_dump_mmu_page_table_s), sizeof(u64))
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_dump_mmu_page_table_s), sizeof(u64)));
                                                                                                                                                                                                                                                                                                                                    ^                         
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:822:300: error: call to '__compiletime_assert_822' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_pp_start_job_s), sizeof(u64))
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_pp_start_job_s), sizeof(u64)));
                                                                                                                                                                                                                                                                                                               ^                         
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:852:330: error: call to '__compiletime_assert_852' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_get_gp_number_of_cores_s), sizeof(u64))
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_get_gp_number_of_cores_s), sizeof(u64)));
                                                                                                                                                                                                                                                                                                                                             ^                         
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:857:321: error: call to '__compiletime_assert_857' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_get_gp_core_version_s), sizeof(u64))
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_get_gp_core_version_s), sizeof(u64)));
                                                                                                                                                                                                                                                                                                                                    ^                         
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:867:318: error: call to '__compiletime_assert_867' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_vsync_event_report_s), sizeof(u64))
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_vsync_event_report_s), sizeof(u64)));
                                                                                                                                                                                                                                                                                                                                 ^                         
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:880:342: error: call to '__compiletime_assert_880' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_timeline_create_sync_fence_s), sizeof(u64))
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_timeline_create_sync_fence_s), sizeof(u64)));
                                                                                                                                                                                                                                                                                                                                                         ^                         
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:888:309: error: call to '__compiletime_assert_888' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_soft_job_signal_s), sizeof(u64))
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_soft_job_signal_s), sizeof(u64)));
                                                                                                                                                                                                                                                                                                                        ^                         

vim +/__compiletime_assert_734 +734 drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c

8e905b3b Michal Simek 2015-06-10  718  	switch (cmd) {
8e905b3b Michal Simek 2015-06-10  719  	case MALI_IOC_WAIT_FOR_NOTIFICATION:
8e905b3b Michal Simek 2015-06-10  720  		BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_wait_for_notification_s), sizeof(u64)));
8e905b3b Michal Simek 2015-06-10  721  		err = wait_for_notification_wrapper(session_data, (_mali_uk_wait_for_notification_s __user *)arg);
8e905b3b Michal Simek 2015-06-10  722  		break;
8e905b3b Michal Simek 2015-06-10  723  
8e905b3b Michal Simek 2015-06-10  724  	case MALI_IOC_GET_API_VERSION_V2:
8e905b3b Michal Simek 2015-06-10  725  		BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_get_api_version_v2_s), sizeof(u64)));
8e905b3b Michal Simek 2015-06-10  726  		err = get_api_version_v2_wrapper(session_data, (_mali_uk_get_api_version_v2_s __user *)arg);
8e905b3b Michal Simek 2015-06-10  727  		break;
8e905b3b Michal Simek 2015-06-10  728  
8e905b3b Michal Simek 2015-06-10  729  	case MALI_IOC_GET_API_VERSION:
8e905b3b Michal Simek 2015-06-10  730  		err = get_api_version_wrapper(session_data, (_mali_uk_get_api_version_s __user *)arg);
8e905b3b Michal Simek 2015-06-10  731  		break;
8e905b3b Michal Simek 2015-06-10  732  
8e905b3b Michal Simek 2015-06-10  733  	case MALI_IOC_POST_NOTIFICATION:
8e905b3b Michal Simek 2015-06-10 @734  		BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_post_notification_s), sizeof(u64)));
8e905b3b Michal Simek 2015-06-10  735  		err = post_notification_wrapper(session_data, (_mali_uk_post_notification_s __user *)arg);
8e905b3b Michal Simek 2015-06-10  736  		break;
8e905b3b Michal Simek 2015-06-10  737  
8e905b3b Michal Simek 2015-06-10  738  	case MALI_IOC_GET_USER_SETTINGS:
8e905b3b Michal Simek 2015-06-10  739  		BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_get_user_settings_s), sizeof(u64)));
8e905b3b Michal Simek 2015-06-10  740  		err = get_user_settings_wrapper(session_data, (_mali_uk_get_user_settings_s __user *)arg);
8e905b3b Michal Simek 2015-06-10  741  		break;
8e905b3b Michal Simek 2015-06-10  742  

:::::: The code at line 734 was first introduced by commit
:::::: 8e905b3b33fa6f3f2f97591500b53d8a8245df29 staging: mali: Add r5p1-01rel0 and r5p2-00rel0 drivers

:::::: TO: Michal Simek <michal.simek@xilinx.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 53211 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170129/9847a92b/attachment-0001.gz>
