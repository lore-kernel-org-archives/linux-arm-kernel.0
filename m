From: carlo@caione.org (Carlo Caione)
Date: Mon, 18 Aug 2014 15:33:25 +0200
Subject: [PATCH 7/7] ARM: meson: update documentation (uart, timer and
 vendors)
In-Reply-To: <53F1D73F.8010204@gmail.com>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-8-git-send-email-carlo@caione.org>
 <53F1D73F.8010204@gmail.com>
Message-ID: <20140818133325.GC28819@carlo-MacBookPro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 12:36:47PM +0200, Matthias Brugger wrote:
> 
> 
> On 17/08/14 12:49, Carlo Caione wrote:
> >New UART and timer bindings are documented. A new vendor is added to the
> >vendors list.
> >
> >Signed-off-by: Carlo Caione <carlo@caione.org>
> >---
> >  .../devicetree/bindings/serial/amlogic,meson-uart.txt   | 17 +++++++++++++++++
> >  .../devicetree/bindings/timer/amlogic,meson6-timer.txt  | 16 ++++++++++++++++
> >  Documentation/devicetree/bindings/vendor-prefixes.txt   |  1 +
> >  3 files changed, 34 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
> >  create mode 100644 Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt
> 
> This should be three patches for the different files. It might
> happen, that for example your timer driver get merged through a
> different tree then arm-soc. For the merge, the driver and the
> documentation should go togehter.

Right. Thank you for pointing this out.

Best,

-- 
Carlo Caione
