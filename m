From: madhavi.linux@gmail.com (Madhavi Manchala)
Date: Tue, 29 Mar 2011 12:01:40 +0530
Subject: MACH_TYPE undeclared error
Message-ID: <AANLkTimSWBx-FTj1WXpOgFXyH6rLSWFNzayLd_yOj7d_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

I have defined a MACHINE_START macro in my board C file as follows.

MACHINE_START(S3C2510, "S3C2510")
	.init_irq	= s3c2510_init_irq,
	.timer		= &s3c2510_time_init,
MACHINE_END

When I try to compile this C file, I am seeing the following error message.

arch/arm/mach-s3c2510/s3c2510.c:35:1: error: 'MACH_TYPE_S3C2510'
undeclared here (not in a function)

I googled, but there is no luck for me. Please suggest me whether I am
missing any configuration item.

Any hints / suggestions would be appreciated.

Thanks and Regards,
Madhavi M.
