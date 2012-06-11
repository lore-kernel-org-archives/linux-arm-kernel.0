From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Jun 2012 12:34:53 +0200
Subject: [PATCH 6.2/7] MMC: mmci: Enable Device Tree support for ux500
In-Reply-To: <4FD5C26E.9080902@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdYyP=V=aXtDuo_W4oDxH0UkQKq1x1HKG_z=zWHoWng6JQ@mail.gmail.com>
 <4F8BE5B0.4000900@linaro.org>
 <20120604101447.GF8262@n2100.arm.linux.org.uk>
 <4FCDE3D7.9030006@linaro.org>
 <20120605105249.GK8262@n2100.arm.linux.org.uk>
 <CACRpkdY=os8B2JEVijHzdfqUN_Q075MLoVsk3U=owAPhmcNUHg@mail.gmail.com>
 <4FD5C26E.9080902@linaro.org>
Message-ID: <CACRpkdZbSpXhg+m8MzOTrB=sGbYW9MDrXyRd_afAExogkgE5-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 12:03 PM, Lee Jones <lee.jones@linaro.org> wrote:

> From: Lee Jones <lee.jones@linaro.org>
> Date: Mon, 11 Jun 2012 10:41:00 +0100
> Subject: [PATCH] mmc: mmci: Allocate platform memory during Device Tree boot
>
> When booting with Device Tree enabled, platform specific information
> is gathered by parsing the DT binary. Platform data is subsequently
> populated with the result. The memory required for this is not
> automatically allocated during Device Tree boot, so we'll do it here
> instead.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Pls put this in Russell's patch tracker.

Yours,
Linus Walleij
