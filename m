From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 21 May 2014 09:54:15 +0200
Subject: [PATCH v4 2/2] ARM: sunxi: dt: Convert to the new i2c compatibles
In-Reply-To: <1396270498-30703-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1396270498-30703-1-git-send-email-maxime.ripard@free-electrons.com>
 <1396270498-30703-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140521075415.GB2708@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 02:54:58PM +0200, Maxime Ripard wrote:
> Switch the device tree to the new compatibles introduced in the i2c drivers
> to have a common pattern accross all Allwinner SoCs.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

I usually don't take dts updates, but I guess it makes sense this time,
because we dropped the old binding?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/91a23f54/attachment-0001.sig>
