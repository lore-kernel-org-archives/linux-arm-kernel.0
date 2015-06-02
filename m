From: balbi@ti.com (Felipe Balbi)
Date: Tue, 2 Jun 2015 14:23:32 -0500
Subject: Regression with AM43xx devices
In-Reply-To: <20150602191752.GE9623@saruman.tx.rr.com>
References: <20150602191752.GE9623@saruman.tx.rr.com>
Message-ID: <20150602192332.GG9623@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 02:17:52PM -0500, Felipe Balbi wrote:
> Hi Dave,
> 
> You commit fabbe6df130a46d5b5e7484b2273d69c4be3012a (ARM: OMAP: AM43xx
> hwmod: Add data for am43xx emif hwmod) listed below added a new WARNING
> during boot to all AM43xx-based boards. Full boot logs can be found at
> [1], but it seems like we should, at least for the merge window, revert
> said commit unless a fix could come it the next couple days or so.o
> 
> ps: note that boot log is for AM43xx IDK, but the same thing has been
> reproduced on AM437x SK.
> 
> [1] http://hastebin.com/kasenikevo

Seems like someone forgot to pick [1] up. I've added my Tested-by as a
reply to that thread.

[1] http://marc.info/?l=linux-omap&m=143093317331247&w=2

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150602/a5c3dd2a/attachment-0001.sig>
