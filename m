From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 8 Nov 2014 19:03:25 +0100
Subject: [PATCH v3 1/3] i2c/at91: add support for runtime PM
In-Reply-To: <1414133417-11530-2-git-send-email-wenyou.yang@atmel.com>
References: <1414133417-11530-1-git-send-email-wenyou.yang@atmel.com>
 <1414133417-11530-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20141108180325.GE4900@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 02:50:15PM +0800, Wenyou Yang wrote:
> Drivers should put the device into low power states proactively whenever the
> device is not in use. Thus implement support for runtime PM and use the
> autosuspend feature to make sure that we can still perform well in case we see
> lots of i2c traffic within short period of time.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141108/ae51c155/attachment.sig>
