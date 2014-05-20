From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 20 May 2014 18:41:45 +0300
Subject: [RFC PATCH 04/10] clk: tegra: Initialize xusb clocks
In-Reply-To: <537513D8.7060203@wwwdotorg.org>
References: <1400113986-339-1-git-send-email-abrestic@chromium.org>
 <1400113986-339-5-git-send-email-abrestic@chromium.org>
 <537513D8.7060203@wwwdotorg.org>
Message-ID: <20140520154145.GY15168@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 09:22:00PM +0200, Stephen Warren wrote:
> On 05/14/2014 06:33 PM, Andrew Bresticker wrote:
> > Initialize the XUSB-related clocks with appropriate parents and rates
> > for both Tegra114 and Tegra124.
> 
> These first 4 clock driver patches look plausible to me, although I
> didn't look that hard!
> 
> Peter or Mike, if they look OK to you, can you please pick them up for
> 3.16 so that by the time we apply the rest of the patches in this series
> for 3.17, the clock dependencies are already there? Thanks.

Looks fine to me. Applied for 3.16, hopefully it will still make it.

Cheers,

Peter.
