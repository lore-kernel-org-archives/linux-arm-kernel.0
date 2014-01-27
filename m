From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Jan 2014 15:45:36 +0100
Subject: [PATCH v2 0/5] clk: sunxi: Add support for USB clocks and reset
 bits
In-Reply-To: <1390426587-16287-1-git-send-email-hdegoede@redhat.com>
References: <1390426587-16287-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20140127144536.GK3867@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 10:36:22PM +0100, Hans de Goede wrote:
> Hi Emilio, Maxime, et al,
> 
> Emilio, here is v2 of my patch-set adding support for sunxi-clk USB clocks and
> reset bits. This addresses all your review comments from v1.
> 
> Can you add the first 2 patches to your queue of patches for Mike for 3.15 ?
> 
> Maxime, can you add patch 3-5 which add the dt bindings for this to your
> tree please ?

Apart from the comments I had on patch 2, it looks good for me. Once
we agree on something, you have my Acked-by.

Thanks for working on this!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140127/cce4f6e6/attachment.sig>
