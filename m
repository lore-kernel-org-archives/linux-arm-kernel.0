From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 19 May 2016 23:39:48 -0300
Subject: mx6ul cannot reboot
In-Reply-To: <DB4PR04MB538C503553C02CE7DDA5385874B0@DB4PR04MB538.eurprd04.prod.outlook.com>
References: <CAOMZO5DLz7vBARB+uweDG+tw0UM3EMDb9+_XcLaaBv0GN+im7g@mail.gmail.com>
 <CAOMZO5CF7g=GOXL_BMRQTZ6UPk+15z3hkxoM3j+KW033Dtp7wA@mail.gmail.com>
 <DB4PR04MB538C503553C02CE7DDA5385874B0@DB4PR04MB538.eurprd04.prod.outlook.com>
Message-ID: <CAOMZO5A-y86T1HUVDMUnOC6BOKUw87EOCL5oinGu9XNLE-HucQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacky,

On Thu, May 19, 2016 at 11:25 PM, Ping Bai <ping.bai@nxp.com> wrote:
> Hi Fabio,
>
> I have already add cpufreq driver support in imx6q-cpufreq.c before adding the cpufreq device.
> Commit: a35fc5a33b62a6c658b8ffe7544c966c1776d128.

Ok, I see. Can you try to run kernel 4.6 on a mx6ul board and run a
'reboot' command? You will see a crash related to cpufreq.

cpufreq is broken for mx6ul. Could you please take a look?

Thanks
