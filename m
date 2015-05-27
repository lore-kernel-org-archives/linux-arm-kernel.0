From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 May 2015 22:04:51 +0800
Subject: [PATCH v3 12/12] ARM: imx: move timer driver into
 drivers/clocksource
In-Reply-To: <5565BD93.50600@linaro.org>
References: <1432308599-28643-13-git-send-email-shawn.guo@linaro.org>
 <1432530849-12312-1-git-send-email-shawn.guo@linaro.org>
 <5565BD93.50600@linaro.org>
Message-ID: <20150527140448.GJ16165@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 02:50:27PM +0200, Daniel Lezcano wrote:
> On 05/25/2015 07:14 AM, Shawn Guo wrote:
> >After the cleanup on imx timer driver, now it's ready to be moved into
> >drivers/clocksource/.  Let's do it.
> >
> >Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> I don't see the Kconfig change.

As timer-imx-gpt is the only supported timer for i.MX, we use
architecture option CONFIG_ARCH_MXC to control it for now.

Shawn
