From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 2 Dec 2013 10:37:56 +0100
Subject: [PATCH 1/5] clk: tegra: fix blink clock rate
In-Reply-To: <529B8C2D.3000300@wwwdotorg.org>
References: <1384991242-13596-1-git-send-email-swarren@wwwdotorg.org>
 <20131129152241.GM9712@ulmo.nvidia.com>
 <529B8C2D.3000300@wwwdotorg.org>
Message-ID: <20131202093755.GA18060@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 01, 2013 at 12:21:17PM -0700, Stephen Warren wrote:
> On 11/29/2013 08:22 AM, Thierry Reding wrote:
> > On Wed, Nov 20, 2013 at 04:47:18PM -0700, Stephen Warren wrote:
> >> From: Stephen Warren <swarren@nvidia.com>
> >> 
> >> The blink clock rate needs to be configured, or it will run at
> >> ~1Hz rather than the desired 32KHz. If it runs at the wrong rate,
> >> e.g. the SDIO WiFi on Seaboard and Cardhu will fail to be
> >> detected.
> > 
> > How is this related to WiFi?
> 
> The "blink" clock output from Tegra is connected to the WiFi module,
> which then uses it for something; it probably has a PLL connected to
> it that drives all the internal circuitry.

Okay, thanks for explaining.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131202/cfb91343/attachment.sig>
