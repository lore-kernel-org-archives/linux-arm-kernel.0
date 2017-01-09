From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Jan 2017 15:47:35 +0100
Subject: [PATCH 1/6] drivers: pinctrl: add driver for Allwinner H5 SoC
In-Reply-To: <20170105220823.5ai4yvcblmzmaey2@lukather>
References: <20161226162518.5367-1-icenowy@aosc.xyz>
 <20161226162518.5367-2-icenowy@aosc.xyz>
 <20170105220823.5ai4yvcblmzmaey2@lukather>
Message-ID: <CACRpkdbZkJcPDquhspVcp6R01h-oJ13_YiShiQC7i=d2bZBfSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 5, 2017 at 11:08 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Dec 27, 2016 at 12:25:13AM +0800, Icenowy Zheng wrote:

>> +builtin_platform_driver(sun50i_h5_pinctrl_driver);
>
> This also looks very much like the H3. I'll post a patchset during the
> weekend to avoid duplicating those drivers. This was initially done
> for the sun5i, but it very much applies here.

I have applied Maxime's patch set from today.

Icenowy, please investigate the direction taken by Maxime
here for future revisions if needed.

Yours,
Linus Walleij
