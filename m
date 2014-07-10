From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 10 Jul 2014 11:54:30 +0200
Subject: [PATCH v5 8/8] ARM: shmobile: genmai-reference: Enable MTU2 in
 device tree
In-Reply-To: <1404911564-17380-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1404911564-17380-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1404911564-17380-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20140710095430.GD2728@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 03:12:44PM +0200, Laurent Pinchart wrote:
> No more device needs to be added from platform code when booting the
> reference platform, move MTU2 registration from setup-r7s72100.c to
> board-genmai.c and remove the now empty r7s72100_add_dt_devices()
> function.
> 
> As the genmai_add_standard_devices() function is now identical to the
> default init_machine implementation, remove it as well.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Yay, tasty!

Reviewed-by: Wolfram Sang <wsa@sang-engineering.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140710/6021a48d/attachment.sig>
