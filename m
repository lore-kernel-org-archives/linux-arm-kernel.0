From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Wed, 1 Jul 2015 19:04:00 +0200
Subject: macb: zynq: why is SG disabled?
In-Reply-To: <559403E3.3050900@certsign.ro>
References: <559403E3.3050900@certsign.ro>
Message-ID: <55941D80.2090904@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 01/07/2015 17:14, Nicolae Rosia a ?crit :
> Hello,
> 
> After reading the GEM part of Zynq7000 Technical Reference Manual [0], I think that SG should be supported.
> Is there a reason why SG is disabled in macb for Zynq?
> 
> Best regards,
> Nicolae Rosia

Hi Nicolae,

when the scatter-gather patch was introduced, the feature was enabled only on
tested boards to avoid regressions on other boards.
So SG is enabled on sama5d4x and sama5d2x SoCs. SG is disabled on purpose on
sama5d3x.

For Zynq, I think the feature is still disabled just because it has never been
tested.

Best regards,

Cyrille
