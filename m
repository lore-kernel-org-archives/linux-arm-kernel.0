From: balbi@ti.com (Felipe Balbi)
Date: Tue, 7 Aug 2012 15:38:05 +0300
Subject: [PATCH v3] i2c: omap: switch over to autosuspend API
In-Reply-To: <1344343036-8832-1-git-send-email-balbi@ti.com>
References: <1344343036-8832-1-git-send-email-balbi@ti.com>
Message-ID: <20120807123803.GB8468@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2012 at 03:37:16PM +0300, Felipe Balbi wrote:
> this helps us reduce unnecessary pm transitions
> in case we have another i2c message starting soon.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

ignore this one. sorry

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120807/baf82eb4/attachment.sig>
