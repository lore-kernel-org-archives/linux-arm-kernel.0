From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 26 Aug 2010 06:51:57 +0200
Subject: [PATCH v3 0/2] added initial support for TPO TD043MTEA1 LCD
	display on Aspenite
In-Reply-To: <1282794715-28640-1-git-send-email-mark.brown314@gmail.com>
References: <1282794715-28640-1-git-send-email-mark.brown314@gmail.com>
Message-ID: <201008260651.57454.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 26. srpna 2010 05:51:53 Mark F. Brown napsal(a):
> Mark F. Brown (2):
>   pxa168: added framebuffer support code.
>   pxa168: added initial support for TPO TD043MTEA1 LCD display on
>     Aspenite
> 
>  arch/arm/mach-mmp/aspenite.c            |   60
> +++++++++++++++++++++++++++++++ arch/arm/mach-mmp/include/mach/pxa168.h | 
>   8 ++++
>  arch/arm/mach-mmp/pxa168.c              |    3 ++
>  3 files changed, 71 insertions(+), 0 deletions(-)

It looks good to me, but the hardware specific goo is up to Haojian/Eric to 
check.

Cheers
