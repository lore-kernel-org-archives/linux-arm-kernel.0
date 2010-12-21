From: tony@atomide.com (Tony Lindgren)
Date: Mon, 20 Dec 2010 17:14:02 -0800
Subject: [PATCHv2] omap: rx51: Switch rx51_tpa6130a2_data __initdata to
	__initdata_or_module
In-Reply-To: <1292696230-31901-1-git-send-email-jhnikula@gmail.com>
References: <20101218002439.GA5941@atomide.com>
	<1292696230-31901-1-git-send-email-jhnikula@gmail.com>
Message-ID: <20101221011402.GF5941@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jarkko Nikula <jhnikula@gmail.com> [101218 10:17]:
> If the TPA6130 is compiled as module the id and power_gpio values are
> arbitrary at module probing time since the rx51_tpa6130a2_data was marked as
> __initdata. Fix this by using __initdata_or_module. Then __initdata is
> defined only if the kernel is built without CONFIG_MODULES and omitted
> otherwise.

Thanks applying.

Tony
