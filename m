From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 Aug 2013 10:04:41 +0200
Subject: [PATCH v2] ARM: sunxi: dt: Add device tree for Mele A1000
In-Reply-To: <1376435901-6617-1-git-send-email-emilio@elopez.com.ar>
References: <20130813203001.GC28819@lukather>
 <1376435901-6617-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <20130814080441.GD28819@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 08:18:21PM -0300, Emilio L?pez wrote:
> This adds a device tree usable on Mele A1000 (and A2000, as it
> apparently is the same device except for the case). This device features
> one UART port, Ethernet, an AXP209 PMU on i2c0 and two user configurable
> LEDs.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

Applied with a minor fix to the soc node address on my sunxi/dt-for-3.12
branch.

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130814/bcbfefa0/attachment.sig>
