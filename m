From: mindentropy@gmail.com (mind entropy)
Date: Tue, 4 Jun 2013 13:11:04 +0530
Subject: On mini2440 IO mappings.
Message-ID: <CAM2a4uxNKhD_+zr7mZOV0eR7u_VTCSZyEcsj_uNA5MuuKPFbDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

   I am going through the mini2440 source code for my understanding of
porting an ARM board to linux. I have a doubt regarding initial
mappings sizes of the IRQ, GPIO etc. In
arch/arm/mach-s3c24xx/include/mach/map.h S3C24XX_SZ_IRQ is set to
SZ_1M but in the documentation (Pg 1-27 of s3c2440.pdf datasheet) the
physical address extends from 0X4A000000 to 0X4A00001C. So shouldn't a
size of 4K(small page) or 1K(tiny page) be enough?

Thanks,
Gautam.
