From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 Oct 2013 13:47:12 +0200
Subject: [PATCH v2 5/5] pinctrl: rockchip: emulate both edge triggered
 interrupts
In-Reply-To: <201310160109.08771.heiko@sntech.de>
References: <201310160106.42329.heiko@sntech.de>
 <201310160109.08771.heiko@sntech.de>
Message-ID: <CACRpkdY88+21J3GaUSaZ5LYA5q2Xw+ak58UKe_8qaMucsT5cdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 1:09 AM, Heiko St?bner <heiko@sntech.de> wrote:

> The gpio interrupt controller on Rockchip socs can do edge triggers only
> for single edges but not both. Nevertheless a lot of gpio users rely on
> the availability of both-edge triggered interrupts - i.e. gpio-keys.
>
> Therefore implement a solution similar to pinctrl-coh901 re-setting the
> triggering edge depending on the gpio value in the interrupt demuxer.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Patch applied.

Yours,
Linus Walleij
