From: rogershimizu@gmail.com (Roger Shimizu)
Date: Mon, 25 Jan 2016 08:32:19 +0900
Subject: [PATCH v2] ARM: dts: orion5x: gpio pin fixes for linkstation
 lswtgl
In-Reply-To: <1453388436-8390-1-git-send-email-rogershimizu@gmail.com>
References: <1453286688-9533-1-git-send-email-rogershimizu@gmail.com>
 <1453388436-8390-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <CAEQ9gEkCRsBZZZyD3B4Wi6NrYEmUp9hn3wpu5Cji_90ULUOAUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2016 at 12:00 AM, Roger Shimizu <rogershimizu@gmail.com> wrote:
> Here're a few gpio pin related fixes:
>   - remove pinctrl-0 definition from pinctrl, since those pins are used
>     in other places such as gpio-fan and regulators.
>   - keep initial state of power led
>   - fix for alarm pin of gpio-fan.
>
> Fixes: dc57844a736f ("ARM: dts: orion5x: add buffalo linkstation ls-wtgl")
> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
> ---
>  arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Dear Andrew,

Could you kindly review this patch, please?
It's fixing the similar things as for kirkwood-lswxl.dts [0], which is
already reviewed OK.
Thank you all the time!

[0]: http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/400933.html

Cheers
