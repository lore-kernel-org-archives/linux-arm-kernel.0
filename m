From: abhijitnaik27@gmail.com (abhijit)
Date: Tue, 10 Apr 2018 13:00:42 +0530
Subject: A200 driver submission for Linux mainline kernel
Message-ID: <2b051c2c-59c4-2ea6-8f70-58dd16b02e8a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I have tested A200/Z430 3D driver for Freescale IMX535/537 SoC by using 
port from freedreno. I wanted to submit driver patch to linux 4.14.1 for 
mainlining A200 driver support

Currently w.r.t 4.14.1 kernel, the patch has, 109 files changes, 279170 
insertions, 60 deletions

Major part of the code is taken from A200 support from Freescale Linux 
(2.6.35, 
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/?h=imx_2.6.35)

My question was, can I submit the patch for Linux 4.14.1 kernel for 
mainlining purpose instead of linux-next?

Please point me to any case-study where such huge enhancements were 
mainlined in the past.

Any suggestions for optimizing the mainlining process?

Regards,

 ?? Abhijit
