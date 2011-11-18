From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 18 Nov 2011 13:38:27 -0800
Subject: [PATCH 03/10] arm/tegra: prepare clock code for multiple tegra
 variants
In-Reply-To: <CAOesGMix=CG5s8Ux_fiLKmSqdoVJgm5skm2MBrHg3YrNCyHaUg@mail.gmail.com>
References: <1321546766-26770-1-git-send-email-pdeschrijver@nvidia.com>
 <1321546766-26770-4-git-send-email-pdeschrijver@nvidia.com>
 <20111118190649.GB31678@quad.lixom.net>
 <74CDBE0F657A3D45AFBB94109FB122FF1740D74F48@HQMAIL01.nvidia.com>
 <CAOesGMix=CG5s8Ux_fiLKmSqdoVJgm5skm2MBrHg3YrNCyHaUg@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1740D74F95@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Friday, November 18, 2011 2:25 PM:
> On Fri, Nov 18, 2011 at 12:18 PM, Stephen Warren <swarren@nvidia.com> wrote:
> > Olof Johansson wrote at Friday, November 18, 2011 12:07 PM:
> >> On Thu, Nov 17, 2011 at 06:19:17PM +0200, Peter De Schrijver wrote:
...
> >> > ?void tegra_sdmmc_tap_delay(struct clk *c, int delay)
...
> > I vote just rip this function out altogether.
> >
> > It isn't used in mainline, chromeos-2.6.38, chromeos-3.0, nor our internal
> > 2.6.36 or 2.6.39 kernels.
...
> 
> Actually, it used on some of the chromeos platforms, in particular for...

Oh yes, you're right. I'd grep'd for tegra2_sdmmc_tap_delay instead of
tegra_sdmmc_tap_delay, and saw hits in the clock code so didn't figure I'd
grep'd for the wrong thing.

-- 
nvpublic
