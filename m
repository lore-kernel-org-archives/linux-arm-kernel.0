From: lkp@intel.com (kbuild test robot)
Date: Wed, 10 Oct 2018 05:52:40 +0800
Subject: [xlnx:master 2010/2013]
 drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c:316:23: note: in
 expansion of macro 'ETH_IPV6_SOURCE_ADD_31_0_MASK'
Message-ID: <201810100538.ql4HHp9L%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   7ea1af329aee531681b87b1fba5496337bff680f
commit: f3897f02df67f22dee941923e670212489082160 [2010/2013] staging: xroeframer: IPv6 sysfs source file commit
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout f3897f02df67f22dee941923e670212489082160
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from drivers/staging/xroeframer/xroe_framer.h:7:0,
                    from drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c:14:
   drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c: In function 'ipv6_source_address_show':
   drivers/staging/xroeframer/roe_framer_ctrl.h:877:39: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV6_SOURCE_ADD_31_0_MASK 0x4294967295 /* 4294967295 */
                                          ^
>> drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c:316:23: note: in expansion of macro 'ETH_IPV6_SOURCE_ADD_31_0_MASK'
     unsigned long mask = ETH_IPV6_SOURCE_ADD_31_0_MASK;
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/xroeframer/roe_framer_ctrl.h:884:40: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV6_SOURCE_ADD_63_32_MASK 0x4294967295 /* 4294967295 */
                                           ^
>> drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c:328:9: note: in expansion of macro 'ETH_IPV6_SOURCE_ADD_63_32_MASK'
     mask = ETH_IPV6_SOURCE_ADD_63_32_MASK;
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/xroeframer/roe_framer_ctrl.h:891:40: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV6_SOURCE_ADD_95_64_MASK 0x4294967295 /* 4294967295 */
                                           ^
>> drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c:336:9: note: in expansion of macro 'ETH_IPV6_SOURCE_ADD_95_64_MASK'
     mask = ETH_IPV6_SOURCE_ADD_95_64_MASK;
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/xroeframer/roe_framer_ctrl.h:898:41: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV6_SOURCE_ADD_127_96_MASK 0x4294967295 /* 4294967295 */
                                            ^
>> drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c:344:9: note: in expansion of macro 'ETH_IPV6_SOURCE_ADD_127_96_MASK'
     mask = ETH_IPV6_SOURCE_ADD_127_96_MASK;
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c: In function 'ipv6_source_address_store':
   drivers/staging/xroeframer/roe_framer_ctrl.h:877:39: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV6_SOURCE_ADD_31_0_MASK 0x4294967295 /* 4294967295 */
                                          ^
   drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c:375:23: note: in expansion of macro 'ETH_IPV6_SOURCE_ADD_31_0_MASK'
     unsigned long mask = ETH_IPV6_SOURCE_ADD_31_0_MASK;
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/xroeframer/roe_framer_ctrl.h:884:40: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV6_SOURCE_ADD_63_32_MASK 0x4294967295 /* 4294967295 */
                                           ^
   drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c:388:10: note: in expansion of macro 'ETH_IPV6_SOURCE_ADD_63_32_MASK'
      mask = ETH_IPV6_SOURCE_ADD_63_32_MASK;
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/xroeframer/roe_framer_ctrl.h:891:40: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV6_SOURCE_ADD_95_64_MASK 0x4294967295 /* 4294967295 */
                                           ^
   drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c:396:10: note: in expansion of macro 'ETH_IPV6_SOURCE_ADD_95_64_MASK'
      mask = ETH_IPV6_SOURCE_ADD_95_64_MASK;
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/xroeframer/roe_framer_ctrl.h:898:41: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV6_SOURCE_ADD_127_96_MASK 0x4294967295 /* 4294967295 */
                                            ^
   drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c:404:10: note: in expansion of macro 'ETH_IPV6_SOURCE_ADD_127_96_MASK'
      mask = ETH_IPV6_SOURCE_ADD_127_96_MASK;
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c: In function 'ipv6_destination_address_show':
   drivers/staging/xroeframer/roe_framer_ctrl.h:905:44: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV6_DESTINATION_ADD_31_0_MASK 0x4294967295 /* 4294967295 */
                                               ^
>> drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c:428:23: note: in expansion of macro 'ETH_IPV6_DESTINATION_ADD_31_0_MASK'
     unsigned long mask = ETH_IPV6_DESTINATION_ADD_31_0_MASK;
                          ^
   drivers/staging/xroeframer/roe_framer_ctrl.h:912:45: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV6_DESTINATION_ADD_63_32_MASK 0x4294967295 /* 4294967295 */
                                                ^
>> drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c:440:9: note: in expansion of macro 'ETH_IPV6_DESTINATION_ADD_63_32_MASK'
     mask = ETH_IPV6_DESTINATION_ADD_63_32_MASK;
            ^
   drivers/staging/xroeframer/roe_framer_ctrl.h:919:45: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV6_DESTINATION_ADD_95_64_MASK 0x4294967295 /* 4294967295 */
                                                ^
>> drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c:448:9: note: in expansion of macro 'ETH_IPV6_DESTINATION_ADD_95_64_MASK'
     mask = ETH_IPV6_DESTINATION_ADD_95_64_MASK;
            ^
   drivers/staging/xroeframer/roe_framer_ctrl.h:926:46: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV6_DESTINATION_ADD_127_96_MASK 0x4294967295 /* 4294967295 */
                                                 ^
>> drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c:456:9: note: in expansion of macro 'ETH_IPV6_DESTINATION_ADD_127_96_MASK'
     mask = ETH_IPV6_DESTINATION_ADD_127_96_MASK;
            ^
   drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c: In function 'ipv6_destination_address_store':
   drivers/staging/xroeframer/roe_framer_ctrl.h:905:44: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV6_DESTINATION_ADD_31_0_MASK 0x4294967295 /* 4294967295 */
                                               ^
   drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c:486:23: note: in expansion of macro 'ETH_IPV6_DESTINATION_ADD_31_0_MASK'
     unsigned long mask = ETH_IPV6_DESTINATION_ADD_31_0_MASK;
                          ^
   drivers/staging/xroeframer/roe_framer_ctrl.h:912:45: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV6_DESTINATION_ADD_63_32_MASK 0x4294967295 /* 4294967295 */
                                                ^
   drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c:499:10: note: in expansion of macro 'ETH_IPV6_DESTINATION_ADD_63_32_MASK'
      mask = ETH_IPV6_DESTINATION_ADD_63_32_MASK;
             ^
   drivers/staging/xroeframer/roe_framer_ctrl.h:919:45: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV6_DESTINATION_ADD_95_64_MASK 0x4294967295 /* 4294967295 */
                                                ^
   drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c:507:10: note: in expansion of macro 'ETH_IPV6_DESTINATION_ADD_95_64_MASK'
      mask = ETH_IPV6_DESTINATION_ADD_95_64_MASK;
             ^
   drivers/staging/xroeframer/roe_framer_ctrl.h:926:46: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV6_DESTINATION_ADD_127_96_MASK 0x4294967295 /* 4294967295 */
                                                 ^
   drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c:515:10: note: in expansion of macro 'ETH_IPV6_DESTINATION_ADD_127_96_MASK'
      mask = ETH_IPV6_DESTINATION_ADD_127_96_MASK;
             ^

vim +/ETH_IPV6_SOURCE_ADD_31_0_MASK +316 drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c

   300	
   301	/**
   302	 * ipv6_source_address_show - Returns the IPv6 source address
   303	 * @kobj:	The kernel object of the entry
   304	 * @attr:	The attributes of the kernel object
   305	 * @buff:	The buffer containing the IPv4 source address
   306	 *
   307	 * Returns the IPv6 source address in xxxx.xxxx.xxxx.xxxx.xxxx.xxxx.xxxx.xxxx
   308	 * format
   309	 *
   310	 * Return: XROE_SIZE_MAX on success
   311	 */
   312	static ssize_t ipv6_source_address_show
   313	(struct kobject *kobj, struct kobj_attribute *attr, char *buff)
   314	{
   315		u32 offset = ETH_IPV6_SOURCE_ADD_31_0_OFFSET;
 > 316		unsigned long mask = ETH_IPV6_SOURCE_ADD_31_0_MASK;
   317		u32 buffer = 0;
   318		u32 source_add[4];
   319		u16 source_add16[8];
   320		void __iomem *working_address = ((u8 *)lp->base_addr +
   321		ETH_IPV6_SOURCE_ADD_31_0_ADDR);
   322	
   323		buffer = ioread32(working_address);
   324		source_add[0] = (buffer & mask) >> offset;
   325	
   326		working_address = ((u8 *)lp->base_addr +
   327		ETH_IPV6_SOURCE_ADD_63_32_ADDR);
 > 328		mask = ETH_IPV6_SOURCE_ADD_63_32_MASK;
   329		offset = ETH_IPV6_SOURCE_ADD_63_32_OFFSET;
   330	
   331		buffer = ioread32(working_address);
   332		source_add[1] = (buffer & mask) >> offset;
   333	
   334		working_address = ((u8 *)lp->base_addr +
   335		ETH_IPV6_SOURCE_ADD_95_64_ADDR);
 > 336		mask = ETH_IPV6_SOURCE_ADD_95_64_MASK;
   337		offset = ETH_IPV6_SOURCE_ADD_95_64_OFFSET;
   338	
   339		buffer = ioread32(working_address);
   340		source_add[2] = (buffer & mask) >> offset;
   341	
   342		working_address = ((u8 *)lp->base_addr +
   343		ETH_IPV6_SOURCE_ADD_127_96_ADDR);
 > 344		mask = ETH_IPV6_SOURCE_ADD_127_96_MASK;
   345		offset = ETH_IPV6_SOURCE_ADD_127_96_OFFSET;
   346	
   347		buffer = ioread32(working_address);
   348		source_add[3] = (buffer & mask) >> offset;
   349	
   350		utils_ipv6addr_32to16(source_add, source_add16);
   351		sprintf(buff, "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
   352			source_add16[0], source_add16[1], source_add16[2],
   353			source_add16[3],
   354			source_add16[4], source_add16[5], source_add16[6],
   355			source_add16[7]);
   356		return XROE_SIZE_MAX;
   357	}
   358	
   359	/**
   360	 * ipv6_source_address_store - Writes to the IPv6 source address sysfs entry
   361	 * @kobj:	The kernel object of the entry
   362	 * @attr:	The attributes of the kernel object
   363	 * @buff:	The buffer containing the IPv4 source address
   364	 * @count:	The number of characters typed by the user
   365	 *
   366	 * Writes to the IPv6 source address sysfs entry
   367	 *
   368	 * Return: XROE_SIZE_MAX or the value of "count", if that's lesser, on success
   369	 */
   370	static ssize_t ipv6_source_address_store
   371	(struct kobject *kobj, struct kobj_attribute *attr, const char *buff,
   372	size_t count)
   373	{
   374		u32 offset = ETH_IPV6_SOURCE_ADD_31_0_OFFSET;
   375		unsigned long mask = ETH_IPV6_SOURCE_ADD_31_0_MASK;
   376		u32 source_add[4];
   377		void __iomem *working_address = ((u8 *)lp->base_addr +
   378		ETH_IPV6_SOURCE_ADD_31_0_ADDR);
   379	
   380		xroe_size = min_t(size_t, count, (size_t)XROE_SIZE_MAX);
   381		strncpy(xroe_tmp, buff, xroe_size);
   382		if (utils_ipv6addr_chartohex(xroe_tmp, source_add) == 8) {
   383			utils_write32withmask(working_address, source_add[0],
   384					      mask, offset);
   385	
   386			working_address = ((u8 *)lp->base_addr +
   387			ETH_IPV6_SOURCE_ADD_63_32_ADDR);
   388			mask = ETH_IPV6_SOURCE_ADD_63_32_MASK;
   389			offset = ETH_IPV6_SOURCE_ADD_63_32_OFFSET;
   390	
   391			utils_write32withmask(working_address, source_add[1],
   392					      mask, offset);
   393	
   394			working_address = ((u8 *)lp->base_addr +
   395			ETH_IPV6_SOURCE_ADD_95_64_ADDR);
   396			mask = ETH_IPV6_SOURCE_ADD_95_64_MASK;
   397			offset = ETH_IPV6_SOURCE_ADD_95_64_OFFSET;
   398	
   399			utils_write32withmask(working_address, source_add[2],
   400					      mask, offset);
   401	
   402			working_address = ((u8 *)lp->base_addr +
   403			ETH_IPV6_SOURCE_ADD_127_96_ADDR);
 > 404			mask = ETH_IPV6_SOURCE_ADD_127_96_MASK;
   405			offset = ETH_IPV6_SOURCE_ADD_127_96_OFFSET;
   406	
   407			utils_write32withmask(working_address, source_add[3],
   408					      mask, offset);
   409		}
   410		return xroe_size;
   411	}
   412	
   413	/**
   414	 * ipv6_destination_address_show - Returns the IPv6 destination address
   415	 * @kobj:	The kernel object of the entry
   416	 * @attr:	The attributes of the kernel object
   417	 * @buff:	The buffer containing the IPv4 destination address
   418	 *
   419	 * Returns the IPv6 destination address in
   420	 * xxxx.xxxx.xxxx.xxxx.xxxx.xxxx.xxxx.xxxx format
   421	 *
   422	 * Return: XROE_SIZE_MAX on success
   423	 */
   424	static ssize_t ipv6_destination_address_show
   425	(struct kobject *kobj, struct kobj_attribute *attr, char *buff)
   426	{
   427		u32 offset = ETH_IPV6_DESTINATION_ADD_31_0_OFFSET;
 > 428		unsigned long mask = ETH_IPV6_DESTINATION_ADD_31_0_MASK;
   429		u32 buffer = 0;
   430		u32 dest_add[4];
   431		u16 dest_add16[8];
   432		void __iomem *working_address = ((u8 *)lp->base_addr +
   433		ETH_IPV6_DESTINATION_ADD_31_0_ADDR);
   434	
   435		buffer = ioread32(working_address);
   436		dest_add[0] = (buffer & mask) >> offset;
   437	
   438		working_address = ((u8 *)lp->base_addr +
   439		ETH_IPV6_DESTINATION_ADD_63_32_ADDR);
 > 440		mask = ETH_IPV6_DESTINATION_ADD_63_32_MASK;
   441		offset = ETH_IPV6_DESTINATION_ADD_63_32_OFFSET;
   442	
   443		buffer = ioread32(working_address);
   444		dest_add[1] = (buffer & mask) >> offset;
   445	
   446		working_address = ((u8 *)lp->base_addr +
   447		ETH_IPV6_DESTINATION_ADD_95_64_ADDR);
 > 448		mask = ETH_IPV6_DESTINATION_ADD_95_64_MASK;
   449		offset = ETH_IPV6_DESTINATION_ADD_95_64_OFFSET;
   450	
   451		buffer = ioread32(working_address);
   452		dest_add[2] = (buffer & mask) >> offset;
   453	
   454		working_address = ((u8 *)lp->base_addr +
   455		ETH_IPV6_DESTINATION_ADD_127_96_ADDR);
 > 456		mask = ETH_IPV6_DESTINATION_ADD_127_96_MASK;
   457		offset = ETH_IPV6_DESTINATION_ADD_127_96_OFFSET;
   458	
   459		buffer = ioread32(working_address);
   460		dest_add[3] = (buffer & mask) >> offset;
   461	
   462		utils_ipv6addr_32to16(dest_add, dest_add16);
   463		sprintf(buff, "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
   464			dest_add16[0], dest_add16[1], dest_add16[2], dest_add16[3],
   465			dest_add16[4], dest_add16[5], dest_add16[6], dest_add16[7]);
   466		return XROE_SIZE_MAX;
   467	}
   468	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62156 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181010/a18a7116/attachment-0001.gz>
