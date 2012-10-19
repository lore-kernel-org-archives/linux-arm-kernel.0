From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 19 Oct 2012 04:24:52 +0200
Subject: [PATCH 01/10] pinctrl: use postcore_initcall
In-Reply-To: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20121019022452.GG12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:06 Thu 18 Oct     , Haojian Zhuang wrote:
> Since pins are configured in device driver, pinctrl driver should be
> loaded by those device driver. module_platform_driver() only declares
> pinctrl driver is in module_initcall privilege. Use postcore_initcall
> privilege instead.
this  should not be mandatory as you can use defer probe

Best Regards,
J.
