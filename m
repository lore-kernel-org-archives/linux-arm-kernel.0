From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Dec 2013 11:16:51 +0000
Subject: [PATCH v3 1/3] regulator: act8865: add PMIC act8865 driver
In-Reply-To: <1387343691-18985-2-git-send-email-wenyou.yang@atmel.com>
References: <1387343691-18985-1-git-send-email-wenyou.yang@atmel.com>
 <1387343691-18985-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20131218111651.GE28455@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 01:14:49PM +0800, Wenyou Yang wrote:

> +/* ACt8865 voltage table */
> +static const unsigned int act8865_voltages_table[] = {
> +	600000,		625000,		650000,		675000,

Like I say you should be able to use regulator_map_voltage_linear_range().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/5a8f654f/attachment.sig>
