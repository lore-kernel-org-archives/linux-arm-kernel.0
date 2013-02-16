From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 15 Feb 2013 18:52:34 -0800
Subject: [PATCH v2] clk: Add axi-clkgen driver
In-Reply-To: <1358949892-19986-1-git-send-email-lars@metafoo.de>
References: <1358949892-19986-1-git-send-email-lars@metafoo.de>
Message-ID: <20130216025234.11471.8029@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lars-Peter Clausen (2013-01-23 06:04:52)
> +static const struct of_device_id axi_clkgen_ids[] = {
> +       { .compatible = "adi,axi-clkgen-1.00.a" },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, axi_clkgen_ids);

This method is deprecated.  Can you convert over to the newer
of_clk_init method?  See:

http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=commit;h=f2f6c2556dcc432e50003bc8fa4d62d95906f149

Thanks,
Mike
