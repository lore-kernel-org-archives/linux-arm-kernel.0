From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 22 Feb 2016 17:59:50 -0300
Subject: iMX7d cpu1 issue
In-Reply-To: <AMSPR04MB2634AA127C6397584AF6BA488A30@AMSPR04MB263.eurprd04.prod.outlook.com>
References: <56C2D63F.1030408@compulab.co.il> <20160218140913.GY6756@tiger>
 <AMSPR04MB263D00A3F8D9A8D9D3A536D88AF0@AMSPR04MB263.eurprd04.prod.outlook.com>
 <56C5F4D7.1070704@compulab.co.il>
 <AMSPR04MB26334EB884FA8A4B565278188AF0@AMSPR04MB263.eurprd04.prod.outlook.com>
 <56C6CE36.6040503@compulab.co.il>
 <CAOMZO5Aa+veHWQCrKGz4rsvmjKWiitd81D8ncGnX8Fdk0aYe7Q@mail.gmail.com>
 <AMSPR04MB2634AA127C6397584AF6BA488A30@AMSPR04MB263.eurprd04.prod.outlook.com>
Message-ID: <CAOMZO5Dp-NCktEWrMuuot3T1dV386tkSoHU_DAtBYiJQbBm33A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

On Mon, Feb 22, 2016 at 5:48 PM, Frank Li <frank.li@nxp.com> wrote:

> Upstream kernel use PSCI to enable second core.  You can't define CONFIG_MX7_SEC.
>
> NXP released kernel use legacy method, which require kernel run in security mode. So you have to define CONFIG_MX7_SEC.

Thanks for the clarification.

With linux-next I can see the two cores brought up:

[    0.005377] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.007734] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.007862] Brought up 2 CPU
