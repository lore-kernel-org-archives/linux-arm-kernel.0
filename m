From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Dec 2013 18:50:32 +0800
Subject: [PATCH v3 RESEND] ARM: imx: pllv1: Fix PLL calculation for i.MX27
In-Reply-To: <1384076089-30536-1-git-send-email-shc_work@mail.ru>
References: <1384076089-30536-1-git-send-email-shc_work@mail.ru>
Message-ID: <20131203105030.GA13726@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 10, 2013 at 01:34:49PM +0400, Alexander Shiyan wrote:
> MFN bit 9 on i.MX27 has a different meaning than in other SOCs. This
> is a just sign bit. This patch makes different calculation for i.MX27.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied, thanks.
