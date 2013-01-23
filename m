From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 23 Jan 2013 10:23:13 -0500 (EST)
Subject: [PATCH 1/2] usb: host: tegra: don't touch EMC clock
In-Reply-To: <1358900903-27654-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <Pine.LNX.4.44L0.1301231022560.2045-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Jan 2013, Stephen Warren wrote:

> From: Stephen Warren <swarren@nvidia.com>
> 
> Clock "emc" is for the External Memory Controller. The USB driver has no
> business touching this clock directly. Remove the code that does so.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Greg, Alan, I'd like to take this patch through the Tegra tree to avoid
> any merge conflicts with the Tegra USB changes that have  recently
> happened there.

It's okay with me.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
