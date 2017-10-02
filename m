From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 2 Oct 2017 22:38:53 +0200
Subject: [PATCH v3 05/12] pinctrl: axp209: add support for AXP813 GPIOs
In-Reply-To: <20171002120854.5212-6-quentin.schulz@free-electrons.com>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
 <20171002120854.5212-6-quentin.schulz@free-electrons.com>
Message-ID: <20171002203853.ofvrds47il5d6ca6@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 02, 2017 at 12:08:47PM +0000, Quentin Schulz wrote:
> The AXP813 has only two GPIOs. GPIO0 can either be used as a GPIO, an
> LDO regulator or an ADC. GPIO1 can be used either as a GPIO or an LDO
> regulator.
> 
> Moreover, the status bit of the GPIOs when in input mode is not offset
> by 4 unlike the AXP209.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171002/330ddccc/attachment.sig>
