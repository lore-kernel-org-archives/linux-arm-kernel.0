From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 12 May 2015 21:19:34 +0200
Subject: [PATCH] i2c: omap: implement bus recovery
In-Reply-To: <1430931027-19955-1-git-send-email-balbi@ti.com>
References: <1430931027-19955-1-git-send-email-balbi@ti.com>
Message-ID: <20150512191934.GD4449@schokonusskuchen.bad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 11:50:27AM -0500, Felipe Balbi wrote:
> implement bus recovery methods for i2c-omap
> so we can recover from situations where SCL/SDA
> are stuck low.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150512/5b5261f3/attachment-0001.sig>
