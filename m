From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Oct 2014 21:01:11 +0100
Subject: [PATCH v8 8/8] ARM: multi_v7_defconfig: Enable Broadcom Cygnus
In-Reply-To: <1414525992-3678-9-git-send-email-sbranden@broadcom.com>
References: <1414525992-3678-9-git-send-email-sbranden@broadcom.com>
Message-ID: <5089697.D8odgNlVtY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 October 2014 12:53:12 Scott Branden wrote:
> From: Ray Jui <rjui@broadcom.com>
> 
> Enable Broadcom Cygnus platform support in multi_v7_defconfig
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Signed-off-by: Scott Branden <sbranden@broadcom.com>
> 

Just to be sure: did you check that multi_v7_defconfig contains
all the drivers you need that you enable in your other defconfig?

	Arnd
