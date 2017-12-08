From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 08 Dec 2017 11:54:18 -0800
Subject: [PATCH] pinctrl: meson-axg: adjust spicc pin naming
In-Reply-To: <20171208152909.15632-1-yixun.lan@amlogic.com> (Yixun Lan's
 message of "Fri, 8 Dec 2017 23:29:09 +0800")
References: <20171208152909.15632-1-yixun.lan@amlogic.com>
Message-ID: <7hvahhknbp.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yixun Lan <yixun.lan@amlogic.com> writes:

> According to datasheet, we should use numbers for the pin naming
> instead of letters. The patch here try to fix this to keep
> the consistency.
>
> This patch should not bring any functional change.
>
> Fixes: 83c566806a68 ("pinctrl: meson-axg: Add new pinctrl driver for Meson AXG SoC")
> Suggested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
> The issue was raised by Kevin while review the SPI DT part patches, see [1]
> [1] http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005641.html
>
> Note: the 'Fixes' is coming from pinctrl's tree 'for-next' branch


Linus, please consider this change for your next branch.  I'd like to
get the names aligned with the datasheet before we have any users in DT.

Thanks,

Kevin
