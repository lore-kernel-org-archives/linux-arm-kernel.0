From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 10 Sep 2014 10:08:37 +0800
Subject: [PATCH 1/4] ARM: i.MX: Remove i.MX1 Armadeus APF9328 board support
In-Reply-To: <1409978083-20047-1-git-send-email-shc_work@mail.ru>
References: <1409978083-20047-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140910020835.GF2341@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 06, 2014 at 08:34:40AM +0400, Alexander Shiyan wrote:
> mach-apf9328.c can be replaced with devicetree equivalent: imx1-apf9328.dts,
> so remove the board file.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Hi Alexander,

I would like to apply the series as a cleanup on imx/cleanup branch.
Can you please rebase the series on that branch?

Shawn
