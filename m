From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 1 Dec 2017 16:57:25 +0100
Subject: [PATCH v4 06/10] pinctrl: axp209: add programmable ADC muxing
 value
In-Reply-To: <a4f348914450705f1f784a2148559e19caf9e9fd.1512135804.git-series.quentin.schulz@free-electrons.com>
References: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
 <a4f348914450705f1f784a2148559e19caf9e9fd.1512135804.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20171201155725.7e7oshnjxbdhn3qv@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 02:44:47PM +0100, Quentin Schulz wrote:
> To prepare for patches that will add support for a new PMIC that has a
> different GPIO adc muxing value, add an adc_mux within axp20x_pctl
> structure and use it.
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
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171201/32cd1e33/attachment.sig>
