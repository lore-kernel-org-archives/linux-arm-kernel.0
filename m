From: kishon@ti.com (ABRAHAM, KISHON VIJAY)
Date: Thu, 6 Sep 2012 20:32:41 +0530
Subject: [RFC PATCH 2/5] arm: omap: remove ocp2scp_usb_phy_ick clock node
In-Reply-To: <1338375394-16268-3-git-send-email-kishon@ti.com>
References: <1338375394-16268-1-git-send-email-kishon@ti.com>
 <1338375394-16268-3-git-send-email-kishon@ti.com>
Message-ID: <CAAe_U6Ji3KbqkFcBsZ8m-oLQBHyOQfuKTz+NkaoQyxMLascU5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 30, 2012 at 4:26 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> "ocp2scp_usb_phy_ick" clock node was a fake clock node created
> to control MODULEMODE of ocp2scp. Since the hwmod for ocp2scp is now added
> (which can be used to control MODULEMODE) this clock node is removed.
>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

If there isn't any comments for this patch, can someone queue it up?

Thanks
Kishon
