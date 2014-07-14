From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 14 Jul 2014 10:06:35 +0200
Subject: [PATCH 12/12] ARM: tegra: Convert PMC to a driver
In-Reply-To: <20140711135800.GD23218@tbergstrom-lnx.Nvidia.com>
References: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
 <1405080971-7609-13-git-send-email-thierry.reding@gmail.com>
 <20140711135800.GD23218@tbergstrom-lnx.Nvidia.com>
Message-ID: <20140714080633.GH2081@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 04:58:00PM +0300, Peter De Schrijver wrote:
> On Fri, Jul 11, 2014 at 02:16:11PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > This commit converts the PMC support code to a platform driver. Because
> > the boot process needs to cal into this driver very early, also set up a
> 
> Small typo: 'call' :)

Fixed, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/3c8483b4/attachment.sig>
