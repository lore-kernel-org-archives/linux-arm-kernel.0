From: mgreer@animalcreek.com (Mark A. Greer)
Date: Wed, 11 Apr 2012 14:12:53 -0700
Subject: [PATCH 06/12] arm: omap3: am35x: Add full PWRDM_POWER_INACTIVE
 support
In-Reply-To: <CAORVsuW2Nax4h+SxEJ6dLM1AopAFPQjvK0FHa9N5mEEVCStpQw@mail.gmail.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-7-git-send-email-mgreer@animalcreek.com>
 <CAORVsuW2Nax4h+SxEJ6dLM1AopAFPQjvK0FHa9N5mEEVCStpQw@mail.gmail.com>
Message-ID: <20120411211253.GA7979@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 10:56:01PM +0200, Jean Pihet wrote:
> Hi Mark,
> 
> On Wed, Apr 11, 2012 at 9:05 PM, Mark A. Greer <mgreer@animalcreek.com> wrote:
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> >
> > The am35x family of SoCs only support PWRDM_POWER_ON
> > and PWRDM_POWER_INACTIVE power states. This causes
> > an issue in some areas of the OMAP3 power-related
> > code because of assumptions that PWRDM_POWER_RET
> > and/or PWRDM_POWER_OFF are always valid states.
> >
> > To get am35x SoCs to work properly, add missing support
> > for PWRDM_POWER_INACTIVE and remove assumptions that
> > PWRDM_POWER_RET and PWRDM_POWER_OFF are always valid states.
> >
> > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> 
> I just posted a patch set '[RFC/PATCH v2 0/6] ARM: OMAP2+: PM:
> introduce the power domains functional states' [1] which I think
> should be used to base your patches on. This patch set introduces
> functional states for the power domains power ans logic states, and
> the conversion functions between the internal power and logic states
> and the functional states.
> 
> I would be glad to help on the AM35x support for the functional states.
> 
> What do you think?

Sure.  Sounds like the right thing to do.

> [1] http://marc.info/?l=linux-omap&m=133417729712693&w=2

Thanks for the pointer.  I'll do a little research and contact you
out-of-band.

Mark
--
