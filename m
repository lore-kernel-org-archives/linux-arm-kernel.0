From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Jun 2014 13:39:21 +0200
Subject: [PATCH v4 1/4] of: Add NVIDIA Tegra XUSB pad controller binding
In-Reply-To: <53A164E2.7050407@nvidia.com>
References: <1403006877-19850-1-git-send-email-thierry.reding@gmail.com>
 <53A06BD6.40608@wwwdotorg.org> <53A164E2.7050407@nvidia.com>
Message-ID: <20140619113919.GA28111@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 01:07:30PM +0300, Mikko Perttunen wrote:
> On 17/06/14 19:24, Stephen Warren wrote:
> >On 06/17/2014 06:07 AM, Thierry Reding wrote:
> >>From: Thierry Reding <treding@nvidia.com>
> >>
> >>This patch adds the device tree binding documentation for the XUSB pad
> >>controller found on NVIDIA Tegra SoCs. It exposes both pinmuxing and PHY
> >>capabilities.
> >
> >Thanks. I'll wait for a Tested-by from Mikko and an Acked-by from Linus
> >before taking this series.
> >
> 
> With or without negation added to group_get (see reply to 2/4), the series:
> 
> Tested-by: Mikko Perttunen <mperttunen@nvidia.com>

Thanks. I just sent out another series which addresses the missing
negation in group_get() and the missing BIT() around lane->iddq in
various places as discussed on IRC.

I've also added debugfs support which helps verifying that group_get()
now behaves properly.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140619/5db9f7ce/attachment.sig>
