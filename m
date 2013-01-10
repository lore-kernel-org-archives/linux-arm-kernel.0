From: nm@ti.com (Nishanth Menon)
Date: Thu, 10 Jan 2013 14:49:11 -0600
Subject: [RFC PATCH v3 16/16] ARM: dts: add AM33XX SPI support
In-Reply-To: <20130110204959.GS14660@beef>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
 <1350566815-409-17-git-send-email-mporter@ti.com>
 <508D1791.1040806@ti.com> <20130110193547.GQ14660@beef>
 <20130110194653.GA32519@kahuna> <20130110204959.GS14660@beef>
Message-ID: <20130110204911.GA7586@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:49-20130110, Matt Porter wrote:
> On Thu, Jan 10, 2013 at 01:46:53PM -0600, Nishanth Menon wrote:
> > On 14:35-20130110, Matt Porter wrote:
> > > On Sun, Oct 28, 2012 at 05:01:29PM +0530, Sekhar Nori wrote:
> > > > On 10/18/2012 6:56 PM, Matt Porter wrote:
[...]
> 
> > > > > +				0x19c 0x13	/* mcasp0_ahclkr.spi1_cs0, OUTPUT_PULLUP | MODE3 */
> > > > > +			>;
> > > > 
> > > > Is there a single pinmux setting that provides SPI functionality on the
> > > > bone headers? Or this is specific to a cape you tested with?
> > > 
> > > No, there are two usable settings for spi1 and one setting for spi0.
> > > I'm dropping this from the series since it's specific to how I wired up
> > > the homebrew cape I use for spi testing on the Bone. I publish the
> > > branch where all these extra "test-specific" patches (that aren't intended
> > > to be merged) are at in the cover letter.  Anybody that needs context of
> > > how/what worked and was tested can grab them there.
> > Possibly dumb question:
> > Cant we have pre-usable spi configurations?  Like spi1_configuration1_pins,
> > spi2_configuration1_pins, spi0_configuration1_pins? If documented with
> > P9 pin names in the bone dts, it saves a bit of effort in looking up
> > pad offset when dealing with capes.
> 
> Yes, let's introduce these things separately. I plan to reintroduce
> patches to fix the incorrect 1-based numbering on many of the AM33xx as
> previous ones were dropped...and I think this makes sense on top of
> that.
sounds good to me.

-- 
Regards,
Nishanth Menon
