From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 11 Jul 2014 16:58:00 +0300
Subject: [PATCH 12/12] ARM: tegra: Convert PMC to a driver
In-Reply-To: <1405080971-7609-13-git-send-email-thierry.reding@gmail.com>
References: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
 <1405080971-7609-13-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140711135800.GD23218@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 02:16:11PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This commit converts the PMC support code to a platform driver. Because
> the boot process needs to cal into this driver very early, also set up a

Small typo: 'call' :)

Cheers,

Peter.
