From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Dec 2015 08:20:37 -0800
Subject: [PATCH V3 01/19] ARM: dts: am57xx: cl-som-am57x: add basic
 module support
In-Reply-To: <20151202152326.GA16775@rob-hp-laptop>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-2-git-send-email-lifshitz@compulab.co.il>
 <20151202152326.GA16775@rob-hp-laptop>
Message-ID: <20151203162037.GO23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh@kernel.org> [151202 07:24]:
> On Tue, Dec 01, 2015 at 08:03:03PM +0200, Dmitry Lifshitz wrote:
> > Add support for CompuLab CM-SOM-AM57X board.
> > 
> > CL-SOM-AM57x is a miniature System-on-Module (SoM) based on
> > TI Sitara AM57x ARM Cortex-A15 System-on-Chip family.
> > 
> > https://www.compulab.co.il/products/computer-on-modules/cl-som-am57x-ti-am5728-am5718-system-on-module/
> > 
> > Add basic DT support for standalone module (without a carrier board):
> > 
> > * Memory configuration
> > * Heartbeat led
> > * I2C1 and I2C4
> > * PMIC
> > * SATA
> > 
> > Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
> > Acked-by: Igor Grinberg <grinberg@compulab.co.il>
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applying the whole series into omap-for-v4.5/dt thanks.

Tony
