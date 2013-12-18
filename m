From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Dec 2013 10:48:47 +0100
Subject: [PATCH v2 08/11] ARM: sun4i: dt: mod0 clocks
In-Reply-To: <1387327503-15651-9-git-send-email-emilio@elopez.com.ar>
References: <1387327503-15651-1-git-send-email-emilio@elopez.com.ar>
 <1387327503-15651-9-git-send-email-emilio@elopez.com.ar>
Message-ID: <20131218094847.GD2718@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Tue, Dec 17, 2013 at 09:45:00PM -0300, Emilio L?pez wrote:
> This commit adds all the mod0 clocks present on sun4i to its device tree
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Even though I gave my Acked-by, could you rename the nodes to
something like: "foo_clk: clk at deadbeef"

The node name is supposed to be the class of devices, and we're likely
to use all those labels for the actual controllers, and not the clocks
themselves.

Thanks
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/fc455678/attachment.sig>
