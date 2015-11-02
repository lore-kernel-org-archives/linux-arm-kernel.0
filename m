From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 2 Nov 2015 15:36:08 -0600
Subject: [PATCH v4 5/6] PCI: layerscape: add PCIe support for LS1043a and
 LS2080a
In-Reply-To: <CADRPPNRQCrSukyjnS1yBck-jaNTWFOFJy3tomeD0HnXwc8WOBQ@mail.gmail.com>
References: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
 <1444979960-24100-5-git-send-email-Minghuan.Lian@freescale.com>
 <20151021213612.GK1583@localhost>
 <CADRPPNSPP1m_7zNF6wEfw9+Bpe=Z_gUA81cSaV4SENVpR34YWQ@mail.gmail.com>
 <20151022180813.GA25693@localhost>
 <CADRPPNRQCrSukyjnS1yBck-jaNTWFOFJy3tomeD0HnXwc8WOBQ@mail.gmail.com>
Message-ID: <20151102213608.GA28371@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2015 at 03:08:04PM -0600, Li Yang wrote:
> On Thu, Oct 22, 2015 at 1:08 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Hi Leo,
> >
> > On Thu, Oct 22, 2015 at 12:38:48PM -0500, Li Yang wrote:
> >> On Wed, Oct 21, 2015 at 4:36 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> > On Fri, Oct 16, 2015 at 03:19:19PM +0800, Minghuan Lian wrote:
> >> >> Both LS1043a and LS2080a are based on ARMv8 64-bit architecture
> >> >> and have similar PCIe implementation. LUT is added to controller.
> >> >> The patch removes the necessary fields from struct ls_pcie.
> >> >>
> >> >> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> >> >> ---
> >> >> This patch is based on v4.3-rc4 and [PATCH v10 3/6]
> >> >> PCI: designware: Add ARM64 support.
> >>
> >> Hi Bjorn,
> >>
> >> Are you also applying this patch
> >> https://patchwork.ozlabs.org/patch/531184/ in this merge windows?
> >> Because the new hardware can only work with the generic ARM64 support
> >> added in the designware pcie driver.
> >
> > I'm reviewing that patch right now, and I do hope to apply it for
> > v4.4.
> >
> > There was no cover letter for this series (Minghuan's Layerscape v4
> > series), and I didn't see any mention of dependencies, so I applied it
> > on top of v4.3-rc1.  Is that the wrong thing to do?  If it depends on
> > the Zhou's v11 series, I can hold the Layerscape branch until after
> > that.
> 
> I noticed that you have merged Zhou's latest patch.  Probably you can
> also merge the Layerscape branch now.

That's my intention.

Bjorn
