From: holgerschurig@gmail.com (Holger Schurig)
Date: Tue, 7 Jul 2015 07:59:27 +0200
Subject: imx6 fsl,fiq-stream-filter
In-Reply-To: <1808860.4aMo44FlnA@jclayton-pc>
References: <A34315704930CF44BA74E64F19E02E917DEEE3FC@S1P5DAG1A.EXCHPROD.USA.NET>
 <1808860.4aMo44FlnA@jclayton-pc>
Message-ID: <CAOpc7mG4pnHGL3BB4h1rYyLD_Bn7nDVQ0bfAmCg10X+f8NiWPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joshua,

> Freescale FIQ demo code has not been updated since their 3.0.35 kernel, which
> was before the majority of the devicetree migration. (and it was a pretty ugly
> hack, even then).

Did you mean this? https://community.freescale.com/docs/DOC-95578

That surely looks very hacky.

I'm currently more-or-less stumble around like a blind one in order to
get FIQ running on i.MX6. Seems that mxc_set_irq_fiq() is a NOP on
i.MX6, because AFAIK this function is only supported by chips with an
TZIC or an AVIC.
