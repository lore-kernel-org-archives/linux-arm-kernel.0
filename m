From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Thu, 18 Oct 2012 21:49:34 +0530
Subject: 3.7-rc-1 Release Causing application failure for compilation
Message-ID: <CA+V-a8uj4wSz60Ov8S3MpSrUe-D5+OcpVsFjURzSEcE6VdvGGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I have updated to 3.7-rc1 kernel version with latest head with
commit-id 43c422eda99b894f18d1cca17bcd2401efaf7bd0
but when I try to cross compile the Application I am getting following errors.

/home/plad/ti/linus/linus/include/linux/types.h:14:26: error:
conflicting types for 'fd_set'
/home/plad/CodeSourcery/Sourcery_G++_Lite/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/select.h:78:5:
note: previous declaration of 'fd_set' was here
/home/plad/ti/linus/linus/include/linux/types.h:15:25: error:
conflicting types for 'dev_t'
/home/plad/CodeSourcery/Sourcery_G++_Lite/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/types.h:61:17:
note: previous declaration of 'dev_t' was here
/home/plad/ti/linus/linus/include/linux/types.h:17:26: error:
conflicting types for 'mode_t'
/home/plad/CodeSourcery/Sourcery_G++_Lite/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/types.h:71:18:
note: previous declaration of 'mode_t' was here
/home/plad/ti/linus/linus/include/linux/types.h:25:26: error:
conflicting types for 'timer_t'
/home/plad/CodeSourcery/Sourcery_G++_Lite/bin/../arm-none-linux-gnueabi/libc/usr/include/time.h:104:19:
note: previous declaration of 'timer_t' was here
/home/plad/ti/linus/linus/include/linux/types.h:134:23: error:
conflicting types for 'blkcnt_t'
/home/plad/CodeSourcery/Sourcery_G++_Lite/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/types.h:236:20:
note: previous declaration of 'blkcnt_t' was here

I use the codesourcery toolchain for cross compiling the applications
for ARM. The same compiler is used to  build the uImage for ARM, but
when I try building the apps I see this issue. Can any help me out in
fixing this.

Regards,
--Prabhakar Lad
