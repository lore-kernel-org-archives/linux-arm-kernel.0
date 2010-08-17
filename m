From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Tue, 17 Aug 2010 14:01:12 +0200
Subject: [PATCH 5/5] ARM: S3C64XX: Add wifi RF kill support for SmartQ
	boards
In-Reply-To: <4c659a71.d37b0e0a.4deb.ffffcd80@mx.google.com>
References: <4c659a71.d37b0e0a.4deb.ffffcd80@mx.google.com>
Message-ID: <4C6A7A08.6060709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Op 13-08-10 21:18, Maurus Cuelenaere schreef:
> This patch create a new platform driver which adds support for RF kill to the
> on-board WM-G-MR-09 wifi chip. It also adds the platform device glue to the
> SmartQ board definitions.
>
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> ---
>  arch/arm/mach-s3c64xx/Kconfig       |    7 ++
>  arch/arm/mach-s3c64xx/Makefile      |    3 +
>  arch/arm/mach-s3c64xx/mach-smartq.c |   38 ++--------
>  arch/arm/mach-s3c64xx/smartq-wifi.c |  135 +++++++++++++++++++++++++++++++++++
>  4 files changed, 152 insertions(+), 31 deletions(-)
>  create mode 100644 arch/arm/mach-s3c64xx/smartq-wifi.c

@Ben:
Any specific reason why you didn't pick this up?

-- 
Maurus Cuelenaere
