From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Mar 2014 11:55:14 +0100
Subject: [PATCH v4 1/3] ARM: sun7i/sun6i: irqchip: Add irqchip driver for
 NMI controller
In-Reply-To: <1393529662-8663-2-git-send-email-carlo@caione.org>
References: <1393529662-8663-1-git-send-email-carlo@caione.org>
 <1393529662-8663-2-git-send-email-carlo@caione.org>
Message-ID: <20140303105514.GV607@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Carlo,

On Thu, Feb 27, 2014 at 08:34:20PM +0100, Carlo Caione wrote:
> Allwinner A20/A31 SoCs have special registers to control / (un)mask /
> acknowledge NMI. This NMI controller is separated and independent from GIC.
> This patch adds a new irqchip to manage NMI.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/2c0a8c14/attachment.sig>
