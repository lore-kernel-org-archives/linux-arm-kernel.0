From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 5 Mar 2014 17:31:31 +0100
Subject: [PATCH v3 1/5] i2c: mv64xxx: Add reset deassert call
In-Reply-To: <1393950521-4173-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1393950521-4173-1-git-send-email-maxime.ripard@free-electrons.com>
 <1393950521-4173-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140305163131.GB9228@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 05:28:37PM +0100, Maxime Ripard wrote:
> The Allwinner A31 SoC using that IP has a reset controller maintaining
> it reset unless told otherwise.
> 
> Add some optional reset support to the driver.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140305/b8068a23/attachment.sig>
