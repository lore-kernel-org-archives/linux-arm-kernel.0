From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 4 Jul 2018 22:05:45 -0300
Subject: [PATCH 0/3] ARM: dts: imx31: add device tree description of basic
 controllers
In-Reply-To: <20180703192934.6080-1-vz@mleia.com>
References: <20180703192934.6080-1-vz@mleia.com>
Message-ID: <CAOMZO5AWr=o1xgD5m7Q6SwrXgf__aVtXTk2GHFV_CryfV4tGiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Tue, Jul 3, 2018 at 4:29 PM, Vladimir Zapolskiy <vz@mleia.com> wrote:
> The changeset combines a number of essential updates to support device tree
> on Freescale i.MX31 powered boards:
> * removal of bogus RNGA registration for i.MX31 (device tree only),
> * the core controllers on the i.MX31 SoC are now properly described,
> * for reference and testing I add basic support of LogicPD MX31Lite board.
>
> There are some missing compatibles in the change 2/3, however at the moment
> I assume that either adding the values can be omitted or deferred, here is
> the exact list:
> * "fsl,imx31-pata"
> * "fsl,imx31-rtc"
> * "fsl,imx31-nand"
> * "fsl,imx31-weim"
>
> To test the changes I used a LogicPD reference board, however note that
> still I have to add a workaround to the old known issue within imx-wdt

Hopefully you and Uwe can reach an agreement on the imx31 watchdog fix :-)
