From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Jul 2014 15:21:18 +0200
Subject: [RFC 4/8] clk: sunxi: add __iomem markings to MMIO pointers
In-Reply-To: <1406519386-4902-5-git-send-email-emilio@elopez.com.ar>
References: <1406519386-4902-1-git-send-email-emilio@elopez.com.ar>
 <1406519386-4902-5-git-send-email-emilio@elopez.com.ar>
Message-ID: <20140728132118.GJ3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 12:49:42AM -0300, Emilio L?pez wrote:
> This commit adds __iomem thoughout the sunxi clock driver, in places
> where it was ommited. This cleans most of the sparse warnings we
> are getting here.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140728/f336c99c/attachment-0001.sig>
