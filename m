From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 7 Aug 2013 17:38:36 +0200
Subject: [PATCH 06/27] drivers/i2c/busses: don't check resource with
 devm_ioremap_resource
In-Reply-To: <1374602524-3398-7-git-send-email-wsa@the-dreams.de>
References: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
 <1374602524-3398-7-git-send-email-wsa@the-dreams.de>
Message-ID: <20130807153836.GK2978@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 08:01:39PM +0200, Wolfram Sang wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/5b19df26/attachment.sig>
