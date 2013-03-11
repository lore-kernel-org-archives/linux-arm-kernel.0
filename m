From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 Mar 2013 10:41:05 -0300
Subject: [PATCH] ARM: imx: fix typo "DEBUG_IMX50_IMX53_UART"
In-Reply-To: <20130311133720.GB25910@S2101-09.ap.freescale.net>
References: <1363007760.3137.69.camel@x61.thuisdomein>
 <20130311133720.GB25910@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5AhjKV=ja+Agr_pMg4ghB6Vux2ciBnr_M8SQuS4AQ4Bzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 11, 2013 at 10:37 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Paul,
>
> On Mon, Mar 11, 2013 at 02:16:00PM +0100, Paul Bolle wrote:
>> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
>> ---
>> 0) Tested by grepping the tree.
>>
>> 1) Typo was added in commit f8c95fe6d9adad72fc7bce90f4ab68d119f50c5b
>> ("ARM: imx: support DEBUG_LL uart port selection for all i.MX SoCs").
>> Looking at that patch and at the tree makes clear that DEBUG_IMX53_UART
>> was intended here.
>
> Thanks for the fixing.  Above comment should really be in the commit
> log.  I just applied the patch as below.

Please see my commit:

commit 7356420cd34e40fe27bf26555b0bf3f2849a43dd
Author: Fabio Estevam <fabio.estevam@freescale.com>
Date:   Tue Jan 22 10:40:55 2013 -0200

    ARM: imx: Remove mx508 support

    Only mx508 based board is mach-mx50_rdp and it has been marked as BROKEN
    for several releases.

    mx508 currently lacks clock support.

    In case someone needs to add mx508 support back, then the
recommended approach
    is to use device tree.

    Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
    Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

,it does remove the MX50 reference, so this patch is not needed.
