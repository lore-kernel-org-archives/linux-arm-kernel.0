From: broonie@kernel.org (Mark Brown)
Date: Mon, 3 Sep 2018 14:41:01 +0100
Subject: [PATCH v4 2/5] regulator: rk808: add RK809 and RK817 support.
In-Reply-To: <1535968829-19418-3-git-send-email-tony.xie@rock-chips.com>
References: <1535968829-19418-1-git-send-email-tony.xie@rock-chips.com>
 <1535968829-19418-3-git-send-email-tony.xie@rock-chips.com>
Message-ID: <20180903134101.GK10302@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2018 at 06:00:26PM +0800, Tony Xie wrote:

>     Add support for the rk809 and rk817 regulator driver.
>     Their specifications are as follows?
>     1. The RK809 and RK809 consist of 5 DCDCs, 9 LDOs
>        and have the same registers for these components except dcdc5.
>     2. The dcdc5 is a boost dcdc for RK817 and is a buck for RK809.
>     3. The RK817 has one switch but The Rk809 has two.
> 
>     The output voltages are configurable and are meant to supply power
>     to the main processor and other components.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180903/e917402a/attachment.sig>
