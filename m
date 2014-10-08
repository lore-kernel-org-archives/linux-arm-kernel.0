From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Oct 2014 09:58:12 +0200
Subject: [PATCH 4/6] ARM: cygnus defconfig : Initial defconfig for
 Broadcom Cygnus SoC
In-Reply-To: <1412746025-11998-5-git-send-email-sbranden@broadcom.com>
References: <1412746025-11998-5-git-send-email-sbranden@broadcom.com>
Message-ID: <1996601.jhvNxNYxnl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 October 2014 22:27:03 Scott Branden wrote:
> From: Jonathan Richardson <jonathar@broadcom.com>
> 
> Tested-by: Jonathan Richardson <jonathar@broadcom.com>
> Reviewed-by: JD (Jiandong) Zheng <jdzheng@broadcom.com>
> Signed-off-by: Scott Branden <sbranden@broadcom.com>

Do you actually need a separate defconfig?

If possible, just add your drivers to multi_v7_defconfig, otherwise
include a justification in the patch changelog why your platform
should have its own defconfig file.

	Arnd
