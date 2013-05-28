From: balbi@ti.com (Felipe Balbi)
Date: Tue, 28 May 2013 20:36:37 +0300
Subject: [PATCH v2] usb: musb: fix clock naming
In-Reply-To: <1369725661-3114-1-git-send-email-yegorslists@googlemail.com>
References: <1369725661-3114-1-git-send-email-yegorslists@googlemail.com>
Message-ID: <20130528173637.GE15794@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 09:21:01AM +0200, yegorslists at googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> 'ick' was changed to 'hsotgusb_ick'
> 'fck' was changed to 'hsotgusb_fck'
> 
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

NAK. Fix your clock data.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130528/2bcee7a7/attachment.sig>
