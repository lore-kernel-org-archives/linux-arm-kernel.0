From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 14:46:14 +0100
Subject: [PATCH 10/31] ARM: tegra: pass reset to
 tegra_powergate_sequence_power_up()
In-Reply-To: <20131129134532.GX22771@ulmo.nvidia.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-11-git-send-email-swarren@wwwdotorg.org>
 <20131129134532.GX22771@ulmo.nvidia.com>
Message-ID: <20131129134613.GY22771@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 02:45:33PM +0100, Thierry Reding wrote:
> On Fri, Nov 15, 2013 at 01:54:05PM -0700, Stephen Warren wrote:
> > From: Stephen Warren <swarren@nvidia.com>
> > 
> > Tegra's clock driver now provides an implementation of the common
> > reset API (include/linux/reset.h). Use this instead of the old Tegra-
> > specific API; that will soon be removed.
> 
> Ah, there it is!
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>

And: Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/7a886112/attachment.sig>
