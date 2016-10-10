From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Oct 2016 09:47:47 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Enable Intel e1000e driver
In-Reply-To: <1475959264-16582-1-git-send-email-scott.branden@broadcom.com>
References: <1475959264-16582-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <8265935.TobkRj9BnG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, October 8, 2016 1:41:04 PM CEST Scott Branden wrote:
> Enable support for the Intel e1000e driver
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> 

Can we make this a loadable module and group it with the other
ethernet drivers?

	Arnd
