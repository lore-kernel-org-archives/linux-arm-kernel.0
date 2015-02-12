From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 12 Feb 2015 15:54:40 +0200
Subject: [PATCH v7 01/16] clk: tegra: Add binding for the Tegra124 DFLL
 clocksource
In-Reply-To: <1420723339-30735-2-git-send-email-mikko.perttunen@kapsi.fi>
References: <1420723339-30735-1-git-send-email-mikko.perttunen@kapsi.fi>
 <1420723339-30735-2-git-send-email-mikko.perttunen@kapsi.fi>
Message-ID: <20150212135440.GG20811@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 03:22:04PM +0200, Mikko Perttunen wrote:
> From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> 
> The DFLL is the main clocksource for the fast CPU cluster on Tegra124
> and also provides automatic CPU rail voltage scaling as well. The DFLL
> is a separate IP block from the usual Tegra124 clock-and-reset
> controller, so it gets its own node in the device tree.
> 

Please add devicetree at vger.kernel.org to the next CC list.

Peter.
