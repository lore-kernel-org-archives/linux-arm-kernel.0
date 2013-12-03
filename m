From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Dec 2013 21:37:19 +0800
Subject: [PATCH] ARM: dts: i.MX27: Configure GPIOs as "input" by default
In-Reply-To: <1385795000-29764-1-git-send-email-shc_work@mail.ru>
References: <1385795000-29764-1-git-send-email-shc_work@mail.ru>
Message-ID: <20131203133717.GL13726@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 30, 2013 at 11:03:20AM +0400, Alexander Shiyan wrote:
> This patch changes the default direction for pins used
> as GPIO to "input". This prevents a short circuit on the
> configuration stage when GPIO-pin is connected to the
> other output pin.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied, thanks.
