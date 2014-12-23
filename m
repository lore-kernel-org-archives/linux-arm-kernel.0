From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 23 Dec 2014 12:55:43 +0100
Subject: clk: samsung: exynos7: Add clocks for MSCL block
In-Reply-To: <5498F6AA.8010405@samsung.com>
References: <1418801617-7593-1-git-send-email-tony.kn@samsung.com>
 <5498F6AA.8010405@samsung.com>
Message-ID: <5499583F.9070604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 23/12/14 05:59, Pankaj Dubey wrote:
>> diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
>> > index a79bf23..95c1160 100644
>> > --- a/drivers/clk/samsung/clk-exynos7.c
>> > +++ b/drivers/clk/samsung/clk-exynos7.c
>> > @@ -34,6 +34,7 @@
>> >   #define DIV_TOPC0		0x0600
>> >   #define DIV_TOPC1		0x0604
>> >   #define DIV_TOPC3		0x060C
>> > +#define	ENABLE_ACLK_TOPC1	0x0804
>
> nit: Tab space between #define and ENABLE_ACLK_TOPC1, should be removed.
> 
> I verified register settings and clock relationships are as per UM I 
> have with me. So other than above nit, everything looks fine.
> 
> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Thanks for you review, I have already fixed the whitespace issue when
applying.

--
Regards,
Sylwester
