From: greg@kroah.com (Greg KH)
Date: Sat, 20 May 2017 10:45:23 +0200
Subject: [PATCH 1/2] ARM: dts: am335x-sl50: Fix card detect pin for mmc1
In-Reply-To: <20170519165144.11508-1-enric.balletbo@collabora.com>
References: <20170519165144.11508-1-enric.balletbo@collabora.com>
Message-ID: <20170520084523.GA4284@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 06:51:43PM +0200, Enric Balletbo i Serra wrote:
> The second version of the hardware moved the card detect pin from gpio0_6
> to gpio1_9, as we won't support the first hardware version fix the pinmux
> configuration of this pin.
> 
> Fixes: 8584d4fc ("ARM: dts: am335x-sl50: Add Toby-Churchill SL50 board support.")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  arch/arm/boot/dts/am335x-sl50.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
