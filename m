From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 Jun 2010 10:17:43 +0100
Subject: [PATCH 2/3] pxa: Fix all devices using wm97xx_batt.h
In-Reply-To: <1275613654-23918-2-git-send-email-marek.vasut@gmail.com>
References: <1275613654-23918-1-git-send-email-marek.vasut@gmail.com>
	<1275613654-23918-2-git-send-email-marek.vasut@gmail.com>
Message-ID: <20100607091743.GB23093@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 04, 2010 at 03:07:33AM +0200, Marek Vasut wrote:
> This file is scheduled for removal, therefore fix all devices that use this
> file to use the suggested wm97xx.h and pass platform data properly.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
