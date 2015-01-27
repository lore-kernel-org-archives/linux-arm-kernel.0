From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Jan 2015 15:03:12 -0800
Subject: [PATCH v3 0/4] ARM: Conexant Digicolor CX92755 SoC support
In-Reply-To: <20150125180855.GA3148@tarshish>
References: <cover.1421219953.git.baruch@tkos.co.il>
 <20150125180855.GA3148@tarshish>
Message-ID: <20150127230312.GB11789@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 25, 2015 at 08:08:55PM +0200, Baruch Siach wrote:
> Hi ARM SoC maintainers,
> 
> On Wed, Jan 14, 2015 at 10:40:29AM +0200, Baruch Siach wrote:
> > This series adds initial support for the Conexant CX92755 SoC. The CX92755 is
> > one of the Digicolor series of SoCs, all sharing many of the same peripherals.
> > The code was tested on the CX92755 evaluation kit, AKA Equinox.
> > 
> > Uses attempting to try this code will most likely also want the UART/console
> > driver available from https://patchwork.kernel.org/patch/5515861/.
> 
> Any chance of having this series merged for 3.20? Arnd has acked this already.

Yep, just had a small comment on naming for the third patch, the rest have been
applied now.


-Olof
