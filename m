From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Jul 2014 16:50:14 +0200
Subject: [PATCH 3/3] pinctrl: rockchip: add drive-strength control for
 rk3288
In-Reply-To: <29291825.rqOIHNJZsg@diego>
References: <3086962.49c4Dnm508@diego>
	<29291825.rqOIHNJZsg@diego>
Message-ID: <CACRpkdZh4Y44QNJibcUAg_8LCsiurKY+F7p4q2qxL2WL5Joz+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 20, 2014 at 1:50 AM, Heiko St?bner <heiko@sntech.de> wrote:

> The rk3288 is the first Rockchip soc handling the drive strength on a per-pin
> basis, while the older ones can set the drive-strength only for specific
> pin-groups. Therefore limit setting the drive-strength to this soc for now.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Patch applied.

Others SoC:s have opted to create sub-drivers on a per-soc basis
when stuff gets too complicated, please keep this in mind if the
file starts growing wild...

Yours,
Linus Walleij
