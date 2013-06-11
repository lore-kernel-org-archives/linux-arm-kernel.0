From: jagarwal@nvidia.com (Jay Agarwal)
Date: Tue, 11 Jun 2013 10:17:52 +0530
Subject: [PATCH V4 2/4] ARM: tegra: pcie: Add tegra3 support
In-Reply-To: <20130610200906.GD25859@mithrandir>
References: <1370445221-17696-1-git-send-email-jagarwal@nvidia.com>
 <51AF68F1.8080307@wwwdotorg.org> <20130610200906.GD25859@mithrandir>
Message-ID: <C79B248886DD134989C8FF6B096A91AB91B616BEEE@BGMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> * PGP Signed by an unknown key
> 
> On Wed, Jun 05, 2013 at 10:36:01AM -0600, Stephen Warren wrote:
> > On 06/05/2013 09:13 AM, Jay Agarwal wrote:
> > > - Make private data structure for each SoC
> > > - Add required Tegra30 clocks and regulators
> > > - Add Tegra30 specific code in enable controller
> > > - Added Tegra30 specific properties in pci binding document
> >
> > It's a bit odd to send an updated version of just some of the patches;
> > reposting a whole series is much easier for the person applying the
> > patches. However, hopefully Thierry can handle it in this case.
> 
> Yes, I think I can handle it. It might be good to have Jay look at the final
> patches when I'm done, though, to make sure I haven't forgotten anything.
> 
Yes, please let me know whenever you have integrated my patches to your repo, so that I can sync, review & verify again.
