From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 20 Nov 2015 09:54:10 +0800
Subject: [PATCH v2 2/3] ARM: sunxi: Really enable LRADC keys in
 sunxi_defconfig
In-Reply-To: <1447983979-12751-2-git-send-email-public_timo.s@silentcreek.de>
References: <1447724578-4786-1-git-send-email-public_timo.s@silentcreek.de>
 <1447983979-12751-1-git-send-email-public_timo.s@silentcreek.de>
 <1447983979-12751-2-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <CAGb2v67bpXhBhWVsHw0vv4N+_PXYfRY3y3WcRuQsqiw8jjn46g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 9:46 AM, Timo Sigurdsson
<public_timo.s@silentcreek.de> wrote:
> Commit be8becb81bdc ("ARM: sunxi_defconfig: Enable LRADC keys
> (KEYBOARD_SUN4I_LRADC)") added CONFIG_KEYBOARD_SUN4I_LRADC=y to
> sunxi_defconfig. However, it depends on CONFIG_KEYBOARD which is
> explicitly disabled in sunxi_defconfig. Hence, the LRADC keys were
> never actually enabled. Remove the line disabling CONFIG_KEYBOARD in
> order to really enable KEYBOARD_SUN4I_LRADC.
>
> Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>

Acked-by: Chen-Yu Tsai <wens@csie.org>
