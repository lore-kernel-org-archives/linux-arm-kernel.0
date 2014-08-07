From: balbi@ti.com (Felipe Balbi)
Date: Thu, 7 Aug 2014 10:24:42 -0500
Subject: [PATCH v2] usb: gadget: at91_udc: move prepare clk into process
 context
In-Reply-To: <1407330702-2926-1-git-send-email-ronald.wahl@raritan.com>
References: <1407330702-2926-1-git-send-email-ronald.wahl@raritan.com>
Message-ID: <20140807152441.GE24581@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 06, 2014 at 03:11:42PM +0200, Ronald Wahl wrote:
> Commit 7628083227b6bc4a7e33d7c381d7a4e558424b6b added clock preparation in
> interrupt context. This is not allowed as it might sleep. Move clock
> preparation into process context (at91udc_probe).

missing Signed-off-by. Also, please resend with linux-usb in the loop.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140807/fbff6d10/attachment.sig>
