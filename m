From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 15 Dec 2015 10:44:00 -0200
Subject: [PATCH] ARM: dts: imx: Fix the assigned-clock mismatch issue on
 imx6q/dl
In-Reply-To: <567006C4.8050906@freescale.com>
References: <1449648955-30835-1-git-send-email-b51503@freescale.com>
 <20151214030750.GF25756@tiger> <20151215085237.GB388@tiger>
 <CAOMZO5BKFqMKpRiM6hV43Ko7YcGHPEChSi1GEBMzg3oGo6_Lnw@mail.gmail.com>
 <567006C4.8050906@freescale.com>
Message-ID: <CAOMZO5D9_G_agDAuYg7JdE_9+2en2soPvBb41sA8_1_YQ3PLFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 10:25 AM, Bai Ping <b51503@freescale.com> wrote:

>> It seems that even after this patch we still have a mismatch:
>> assigned-clocks has 5 members and assigned-clock-parents has 4.
>
> I think if it is the last clock in the assigned-clock list, the
> corresponding
> 'assigned-clock-parents' and 'assigned-clock-rates'  entry can be omitted.

Yes, you are right. Confirmed with
Documentation/devicetree/bindings/clock/clock-bindings.txt and your
patch is correct, thanks:

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
