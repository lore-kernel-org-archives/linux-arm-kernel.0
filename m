From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Jun 2016 18:40:57 +0200
Subject: [PATCH v2] arm: tegra124: remove commas from unit addresses
In-Reply-To: <576810C2.1030401@wwwdotorg.org>
References: <1466298275-15753-1-git-send-email-marcel.ziswiler@toradex.com>
 <576810C2.1030401@wwwdotorg.org>
Message-ID: <20160620164057.GD6175@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 09:50:26AM -0600, Stephen Warren wrote:
> On 06/18/2016 07:04 PM, Marcel Ziswiler wrote:
> > Remove commas from unit addresses as suggested by Rob Herring upon me
> > posting initial Apalis TK1 support:
> > 
> > http://article.gmane.org/gmane.linux.ports.tegra/26608
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>

I'm confused now. I posted almost exactly the same patch a while ago and
we agreed that we couldn't do this because the node names were to be
considered part of the ABI.

Is it or is it not?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160620/01d030a2/attachment.sig>
