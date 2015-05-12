From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 12 May 2015 18:29:17 +0200
Subject: [PATCH 1/4] i2c: imx: Constify platform_device_id
In-Reply-To: <1430495668-31878-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495668-31878-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <20150512162917.GE6805@schokonusskuchen.bad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 02, 2015 at 12:54:25AM +0900, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Squashed the 4 patches and applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150512/f2773fe7/attachment.sig>
