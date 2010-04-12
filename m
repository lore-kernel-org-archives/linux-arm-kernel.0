From: christian.glindkamp@taskit.de (Christian Glindkamp)
Date: Mon, 12 Apr 2010 10:18:00 +0200
Subject: [PATCH 0/2] Support for taskit AT91SAM9G20 boards
In-Reply-To: <1268912416-4886-1-git-send-email-christian.glindkamp@taskit.de>
References: <1268912416-4886-1-git-send-email-christian.glindkamp@taskit.de>
Message-ID: <20100412101800.3a9b5554@christian.taskit.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Mar 2010 12:40:14 +0100
Christian Glindkamp <christian.glindkamp@taskit.de> wrote:

> The following two patches contain a shared board file and defconfig for
> the Stamp9G20 CPU module and the PortuxG20 SBC.
> 
> Christian Glindkamp (2):
>   AT91: taskit PortuxG20 and Stamp9G20 board support
>   AT91: add defconfig for taskit PortuxG20 and Stamp9G20
> 
>  arch/arm/configs/stamp9g20_defconfig | 1456 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-at91/Kconfig           |   15 +
>  arch/arm/mach-at91/Makefile          |    2 +
>  arch/arm/mach-at91/board-stamp9g20.c |  317 ++++++++
>  4 files changed, 1790 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/configs/stamp9g20_defconfig
>  create mode 100644 arch/arm/mach-at91/board-stamp9g20.c
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Should I submit these patches to the patch tracker?

-- 
Development

Tel.: ++49 30 611295-22
Fax : ++49 30 611295-11
--
taskit GmbH
Seelenbinderstr. 33 | D-12555 Berlin
web: http://www.taskit.de
Amtsgericht Charlottenburg: 93HRB39014
Managing director: Thorsten Raulfs
--
