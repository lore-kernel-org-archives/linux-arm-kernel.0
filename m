From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 26 Jan 2018 18:53:54 +0100
Subject: [PATCH v4 2/3] i2c: mv64xxx: Fix clock resource by adding an
 optional bus clock
In-Reply-To: <20180116163540.1092-3-gregory.clement@free-electrons.com>
References: <20180116163540.1092-1-gregory.clement@free-electrons.com>
 <20180116163540.1092-3-gregory.clement@free-electrons.com>
Message-ID: <20180126175354.nlgn43co7klyz4b5@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 05:35:39PM +0100, Gregory CLEMENT wrote:
> On Armada 7K/8K we need to explicitly enable the bus clock. The bus clock
> is optional because not all the SoCs need them but at least for Armada
> 7K/8K it is actually mandatory.
> 
> The binding documentation is updating accordingly.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180126/08bd65eb/attachment.sig>
