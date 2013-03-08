From: Milo.Kim@ti.com (Kim, Milo)
Date: Fri, 8 Mar 2013 01:13:02 +0000
Subject: [PATCH v8 10/12] clk: Kconfig for Palmas clock driver
In-Reply-To: <1362662276-20792-10-git-send-email-ian@slimlogic.co.uk>
References: <1362662276-20792-1-git-send-email-ian@slimlogic.co.uk>
 <1362662276-20792-10-git-send-email-ian@slimlogic.co.uk>
Message-ID: <A874F61F95741C4A9BA573A70FE3998F82E45A0E@DQHE02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  drivers/clk/Kconfig        |    8 ++++++++
>  drivers/clk/Makefile       |    1 +
>  drivers/leds/leds-palmas.c |   19 ++++++-------------

If this patch is for only clock module, then LED patch should be detached.

[PATCH v8 10/12] clk: Kconfig for Palmas clock driver
[PATCH v8 12/12] clk: add a clock driver for palmas
It could be joined into one patch file.

Best Regards,
Milo
