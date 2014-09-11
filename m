From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Sep 2014 18:32:25 +0200
Subject: [PATCH 7/7] ARM: at91: add sama5d4 support to sama5_defconfig
In-Reply-To: <1410450852-1834-8-git-send-email-alexandre.belloni@free-electrons.com>
References: <1410450852-1834-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1410450852-1834-8-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140911183225.1a9363bd@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alexandre Belloni,

On Thu, 11 Sep 2014 17:54:12 +0200, Alexandre Belloni wrote:

> @@ -66,7 +67,6 @@ CONFIG_MTD=y
>  CONFIG_MTD_CMDLINE_PARTS=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_CFI=y
> -CONFIG_MTD_M25P80=y
>  CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_ATMEL=y
>  CONFIG_MTD_SPI_NOR=y

Most likely this is not intended to be part of this patch.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
