From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Tue, 5 Aug 2014 06:52:26 +0000
Subject: Suspend/resume broken on mx5/mx6 running 4.16
In-Reply-To: <20140805061658.GG2167@dragon>
References: <CAOMZO5BN9H-4__2s9yyGiuOBsLO0gf9LOQ0_N1552P8LWJTxCg@mail.gmail.com>
 <9930f46074e04c90a58fa6b01e055ff2@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140805061658.GG2167@dragon>
Message-ID: <49b7977404374663b84c67a88eebc59c@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@freescale.com> Data: Tuesday, August 05, 2014 2:17 PM
>To: Duan Fugang-B38611
>Cc: Fabio Estevam; Sascha Hauer; linux-arm-kernel at lists.infradead.org;
>Russell King; Marek Va?ut
>Subject: Re: Suspend/resume broken on mx5/mx6 running 4.16
>
>On Tue, Aug 05, 2014 at 02:06:18PM +0800, Duan Fugang-B38611 wrote:
>> I use linux net tree cannot reproduce the issue like your log, but show
>another issue as below log:
>> (imx6dl sabresd board, Nfs mount rootfs)
>>
>> root at freescale ~$ uname -r
>> 3.16.0-rc5-01146-gda388973d
>
>Fabio already bisect the issue down to commit a71e3c37960c (net: phy:
>Set the driver when registering an MDIO bus device).  This commit landed
>on mainline after v3.16-rc7, and that may be the reason you do not see it
>on net tree (3.16.0-rc5-01146-gda388973d).
>
>Shawn

Shawn, thanks for your information.
