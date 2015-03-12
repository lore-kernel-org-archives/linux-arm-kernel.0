From: tj@kernel.org (Tejun Heo)
Date: Thu, 12 Mar 2015 08:19:12 -0400
Subject: [PATCH v2 14/17] ata: ahci_tegra: remove power sequence from
 driver
In-Reply-To: <1426162518-7405-15-git-send-email-vinceh@nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
 <1426162518-7405-15-git-send-email-vinceh@nvidia.com>
Message-ID: <20150312121912.GJ25944@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 08:15:15PM +0800, Vince Hsu wrote:
> We have the generic PM domain support for Tegra SoCs now. So remove the
> duplicated sequence here.
> 
> Signed-off-by: Vince Hsu <vinceh@nvidia.com>

Can you please repost this patch w/ Hans de Goede
<hdegoede@redhat.com> cc'd?  Just reposting the patch as a reply to
itself w/ the cc added should do.

Thanks.

-- 
tejun
