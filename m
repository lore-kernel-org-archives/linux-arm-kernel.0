From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 28 Nov 2016 08:33:15 +0100
Subject: [PATCH v3 00/12] Initial Tegra186 support
In-Reply-To: <20161126133927.GE20568@xo-6d-61-c0.localdomain>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20161126133927.GE20568@xo-6d-61-c0.localdomain>
Message-ID: <20161128073315.GA18805@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 26, 2016 at 02:39:27PM +0100, Pavel Machek wrote:
> Hi!
> 
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > Hi everyone,
> > 
> > This is a set of patches to add initial support for Tegra186. It is
> > based on Joseph's patches but I rewrote some of the drivers to be a
> > little easier to comprehend and maintain (hopefully). I've also
> > included clock and reset drivers as a proof of concept.
> 
> Is there any phone/tablet on the market with this chipset?

I'm not aware of any. The chip is primarily targetted at automotive
use-cases and probably not suited for phones or tablets.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161128/602266c6/attachment-0001.sig>
