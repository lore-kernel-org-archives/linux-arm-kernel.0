From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 17 Nov 2013 09:52:59 +0100
Subject: [PATCH v2] ARM: sunxi: dt: add EMAC aliases
In-Reply-To: <1384625849-29849-1-git-send-email-emilio@elopez.com.ar>
References: <1384546600-14384-1-git-send-email-emilio@elopez.com.ar>
 <1384625849-29849-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <20131117085259.GL3538@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 16, 2013 at 03:17:29PM -0300, Emilio L?pez wrote:
> U-Boot uses the ethernet0 alias to locate the right node to fill in
> the MAC address of the first ethernet interface. This patch adds the
> alias on all the sunxi SoCs with EMAC. In this way, people using
> ethernet in U-Boot (eg, for tftp) can keep a consistent address on both
> U-Boot and Linux with no additional effort.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

Applied to my sunxi/dt-for-3.14 branch.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131117/346dec6e/attachment.sig>
