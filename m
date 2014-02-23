From: tj@kernel.org (Tejun Heo)
Date: Sun, 23 Feb 2014 11:10:54 -0500
Subject: [PATCH] ahci_sunxi: Use msleep instead of mdelay
In-Reply-To: <1393156361-18414-1-git-send-email-hdegoede@redhat.com>
References: <1393156361-18414-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20140223161054.GA12149@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 23, 2014 at 12:52:41PM +0100, Hans de Goede wrote:
> ahci_sunxi_phy_init is called from the probe and resume code paths, and
> sleeping is safe in both, so use msleep instead of mdelay.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to libata/for-3.15.  Thanks.

-- 
tejun
