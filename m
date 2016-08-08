From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 8 Aug 2016 21:58:59 +0800
Subject: [PATCH 1/3] ARM: dts: imx6sx-sabreauto: Fix misspelled property
In-Reply-To: <1467691450-22975-2-git-send-email-afaerber@suse.de>
References: <1467691450-22975-1-git-send-email-afaerber@suse.de>
 <1467691450-22975-2-git-send-email-afaerber@suse.de>
Message-ID: <20160808135859.GG4678@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2016 at 06:04:08AM +0200, Andreas F?rber wrote:
> In commit 99fc5ba0bfb6 ("ARM: dts: imx6sx: add i.mx6sx sabreauto board
> support") it should've been enable-sdio-wakeup (not -wakup). But that is
> now considered a legacy name for wakeup-source, so directly use the new
> name instead, as done in commit 26cefdd15db1 for the other occurrence.
> 
> Fixes: 26cefdd15db1 ("ARM: dts: imx: replace legacy wakeup property with 'wakeup-source'")
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

Applied, thanks.
