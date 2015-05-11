From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 11 May 2015 15:25:04 +0200
Subject: [PATCH] ARM: dts: kirkwood: add "nor-jedec" flash compatible
 binding
In-Reply-To: <5550AA08.5060001@free-electrons.com>
References: <1431066079-19725-1-git-send-email-zajec5@gmail.com>
 <5550AA08.5060001@free-electrons.com>
Message-ID: <20150511132504.GR18496@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 03:09:28PM +0200, Gregory CLEMENT wrote:
> Hi Rafa??,
> 
> On 08/05/2015 08:21, Rafa?? Mi??ecki wrote:
> > Starting with commits
> > 8ff16cf ("Documentation: devicetree: m25p80: add "nor-jedec" binding")
> > 1103b85 ("mtd: m25p80: bind to "nor-jedec" ID, for auto-detection")
> > we have "nor-jedec" binding indicating support for JEDEC identification.
> 
> I have the same question that for mvebu: did you actually check that all
> the NOR flash referenced in the dts supports the JEDEC identification?

Hi Gregory

That is a good question, but i've no knowledge in this area.

Rafa??, what is the long term plan? Will the device specific property
be removed sometime in the future, and nor-jedec probing be used to
identify the device? Is this already the actual behaviour?  I've seen
warnings when the DT entry specified the wrong device, something like:
Found ABC, Expected XYZ.

      Andrew
