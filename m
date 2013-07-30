From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 30 Jul 2013 10:50:26 +0800
Subject: [PATCH] ARM: i.MX5 clocks: Remove optional clock setup (CKIH1)
 from i.MX51 template
In-Reply-To: <1374909585-2724-1-git-send-email-shc_work@mail.ru>
References: <1374909585-2724-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130730025024.GC19715@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 11:19:45AM +0400, Alexander Shiyan wrote:
> External high frequency clock CKIH1 is optional for i.MX51, so move
> it setup into boards where it is used.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied, thanks.
