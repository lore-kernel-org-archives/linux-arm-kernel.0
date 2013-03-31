From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 31 Mar 2013 01:58:39 +0000 (UTC)
Subject: [PATCH 1/8] ARM: OMAP2+: hwmod: Remove unused
 _HWMOD_WAKEUP_ENABLED flag
In-Reply-To: <1361354272-18089-2-git-send-email-santosh.shilimkar@ti.com>
References: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com>
 <1361354272-18089-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.DEB.2.00.1303310158280.6436@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Feb 2013, Santosh Shilimkar wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> _HWMOD_WAKEUP_ENABLED is currently unused across the hwmod
> framework. Just get rid of it, so we have one less flag to
> worry about.
> 
> Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks, queued for 3.9.

- Paul
