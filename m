From: khilman@ti.com (Kevin Hilman)
Date: Tue, 21 Feb 2012 16:00:52 -0800
Subject: [PATCHv10 3/4] omap3: add common twl configurations for vdd1 and
 vdd2
In-Reply-To: <1329733568-26676-4-git-send-email-t-kristo@ti.com> (Tero
 Kristo's message of "Mon, 20 Feb 2012 12:26:07 +0200")
References: <1329733568-26676-1-git-send-email-t-kristo@ti.com>
 <1329733568-26676-4-git-send-email-t-kristo@ti.com>
Message-ID: <871upn4tzf.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> VDD1 and VDD2 are the core voltage regulators on OMAP3. VDD1 is used
> to control MPU/IVA voltage, and VDD2 is used for CORE. These regulators
> are needed by DVFS.
>
> Voltage ranges for VDD1 and VDD2 are taken from twl4030/twl5030 data manuals:
> - SWCS019L : TWL4030 ES3.1 Data Manual rev L
> - SWCS030E : TWL5030 ES1.2 Data Manual rev E
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Do you have a similar patch for OMAP4 support?

Kevin
