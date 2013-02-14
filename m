From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 14 Feb 2013 07:20:37 -0300
Subject: [RFC 1/1] ARM: omap2: gpmc: Move binding documentation to
 memory-controller
In-Reply-To: <511BAD97.5050602@ti.com>
References: <1360754003-3988-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1360754003-3988-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <511BAD97.5050602@ti.com>
Message-ID: <20130214102036.GB2429@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 09:13:27AM -0600, Jon Hunter wrote:
> 
> On 02/13/2013 05:13 AM, Ezequiel Garcia wrote:
> > GPMC stands for General Purpose Memory Controller, and it's primarily
> > used to handle memories such as NOR, NAND, SRAM.
> > Note that this controller is also used to handle network controllers
> > such as smsc911x.
> > 
> > This patch moves the documentation binding to memory-controllers,
> > where it belongs.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  .../ti-gpmc.txt => memory-controllers/ti/gpmc.txt} |    0
> >  1 files changed, 0 insertions(+), 0 deletions(-)
> >  rename Documentation/devicetree/bindings/{bus/ti-gpmc.txt => memory-controllers/ti/gpmc.txt} (100%)
> > 
> > diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/memory-controllers/ti/gpmc.txt
> > similarity index 100%
> > rename from Documentation/devicetree/bindings/bus/ti-gpmc.txt
> > rename to Documentation/devicetree/bindings/memory-controllers/ti/gpmc.txt
> 
> I am fine with that. However, make sure you CC the device-tree mailing list.
> 

Sorry about that. I also forgot to put Daniel Mack in CC, who added this
document in the first place.

@Daniel: what do you think?

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
