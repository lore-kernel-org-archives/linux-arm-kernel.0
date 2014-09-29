From: balbi@ti.com (Felipe Balbi)
Date: Mon, 29 Sep 2014 09:03:51 -0500
Subject: [PATCH RESEND] tty: serial: omap: Remove probe error message
In-Reply-To: <1411975782-23709-1-git-send-email-mpa@pengutronix.de>
References: <1411975782-23709-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20140929140351.GE32403@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 09:29:42AM +0200, Markus Pargmann wrote:
> This error message is not necessary. The driver core code will print all
> probe error messages. It also resolves some error codes to proper error
> messages. For example -EPROBE_DEFER will only be printed as an info message.
> 
> This patch removes the error message as the core prints the same
> information.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

fine by me:

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140929/eeeb0b69/attachment.sig>
