From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 26 Apr 2016 08:52:14 -0300
Subject: [PATCH] ARM: dts: imx53-qsb: Fix regulator constraints
In-Reply-To: <20160426031959.GE8870@tiger>
References: <1461089705-8270-1-git-send-email-fabio.estevam@nxp.com>
 <20160426031959.GE8870@tiger>
Message-ID: <CAOMZO5BAVqxGVoVQEPmax2RPNjEf8eO8WQ6S4TSqnOgC=_wG3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tue, Apr 26, 2016 at 12:19 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Tue, Apr 19, 2016 at 03:15:05PM -0300, Fabio Estevam wrote:
>> Currently the imx53-qsb board with a Dialog DA9053 PMIC fails to boot:
>>
>> [    0.397546] LDO3: Bringing 3300000uV into 1800000-1800000uV
>>
>> The LDO3 voltage constraints passed in the device tree do not match
>> the valid range according to the datasheet, so fix this accordingly to
>> allow the board booting again.
>
> So you are saying this is a regression?  If so, please provide the
> commit that introduces the regression.

I can boot mainline kernel fine on a mx53qsb with Dialog PMIC. I only
see this issue with linux-next, so it is OK if you only apply this
into your 'for-next' branch.

Thanks
