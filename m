From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Aug 2013 14:43:36 +0200
Subject: [PATCH 5/5] pinctrl: imx: Use struct type for pins
In-Reply-To: <20130816063706.GL26614@pengutronix.de>
References: <1376050854-3303-1-git-send-email-s.hauer@pengutronix.de>
 <1376050854-3303-6-git-send-email-s.hauer@pengutronix.de>
 <CACRpkdZk4jz3dg6aoZqsMT5VXJUQxwrZOyAVLCU3UsExAXChAA@mail.gmail.com>
 <20130815050842.GF26614@pengutronix.de>
 <CACRpkdZ6Ba=54cc036G34NJdpEhCXiCQpFnKi_eZFXumQSkeog@mail.gmail.com>
 <20130816063706.GL26614@pengutronix.de>
Message-ID: <CACRpkdYU7xVJ3w8KscW9yt47+CXDRVfuNkEadjg9CNWzxHHHzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 16, 2013 at 8:37 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Sun, 28 Jul 2013 16:29:22 +0200
> Subject: [PATCH] pinctrl: imx: Use struct type for pins
>
> The i.MX pinctrl driver uses 5 different arrays for storing the
> informations for pins. This requires five allocations. Instead,
> use a struct type which is more cache friendly, readable and
> requires less allocations. One array of integers is still needed
> since the pinctrl framework forces us to maintain it.
> This also adds checks whether the allocations are succesful which
> were missing.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks, this version applied.

Yours,
Linus Walleij
