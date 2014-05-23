From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 23 May 2014 11:20:39 +0300
Subject: [PATCH v3 2/3] ARM: dts: oma3-gta04: Add display support
In-Reply-To: <1399580212-5183-3-git-send-email-marek@goldelico.com>
References: <1399580212-5183-1-git-send-email-marek@goldelico.com>
 <1399580212-5183-3-git-send-email-marek@goldelico.com>
Message-ID: <537F04D7.4000201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/14 23:16, Marek Belisko wrote:
> This patch add support for lcd display on gta04 board. Display control
> is connected to spi (used spi bitbang driver).
> 
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-gta04.dts | 87 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)

I can take this via my tree.

Tony, can I have your ack on this?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140523/74a029ad/attachment.sig>
