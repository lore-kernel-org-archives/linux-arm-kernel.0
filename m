From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 14 Jul 2010 19:20:29 +0900
Subject: [Bug] make ARCH=arm menuconfig is abnormal due to commit ID:
	63b1f51b2405573d47bf5b9ab6e7cd5c697d3dcc
In-Reply-To: <AANLkTinreCm2ioVWpjknDMwGNhDRlqyENJuOkUZhsB_I@mail.gmail.com>
References: <AANLkTinreCm2ioVWpjknDMwGNhDRlqyENJuOkUZhsB_I@mail.gmail.com>
Message-ID: <001301cb233e$32566b60$97034220$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

os user wrote:
> 
> Hi all,

Hi,
> 
> I found since the commit ID: 63b1f51b2405573d47bf5b9ab6e7cd5c697d3dcc
> 
> $ make ARCH=arm menuconfig
> 
> is abnormal:
> 
> Items in [System Type --> ARM system type (xxxx) -->] can not be
> displayed correctly. It seems the line,
> 
> <snip>
> bool "Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442,
> S3C2443, S3C2450"
> </snip>
> 
> is too long.
> 
Already reported about this issue.

Following is Ben's reply at that time:
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/017030.html

But I'm not sure how it was going on...

> My host machine is,
> 
> Ubuntu 8.10
> Intel(R) Pentium(R) 4 CPU 2.80GHz
> 
> $ gcc --version
> gcc (Ubuntu 4.3.2-1ubuntu12) 4.3.2
> Copyright (C) 2008 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
> PURPOSE.
> 
> BR
> 

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
