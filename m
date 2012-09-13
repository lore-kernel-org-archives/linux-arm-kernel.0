From: mturquette@ti.com (Turquette, Mike)
Date: Thu, 13 Sep 2012 10:23:26 -0700
Subject: [GIT PULL 3/4] mxs clk device tree lookup
In-Reply-To: <20120913060808.GG24290@quad.lixom.net>
References: <1347350100-4674-1-git-send-email-shawn.guo@linaro.org>
 <1347350100-4674-4-git-send-email-shawn.guo@linaro.org>
 <20120913060808.GG24290@quad.lixom.net>
Message-ID: <CAJOA=zO2RK-TA924LrpHjF1ADv3eg=1-ypJYyes9cjYDM=X79g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 11:08 PM, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Sep 11, 2012 at 03:54:58PM +0800, Shawn Guo wrote:
>> The following changes since commit 0a77398b5a68e298f03b1c356c5100fa1decb2e1:
>>
>>   Merge tag 'mxs-dt-3.7' into mxs/clk-dt-lookup (2012-09-11 14:15:00 +0800)
>>
>> are available in the git repository at:
>>
>>
>>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-clk-dt-lookup
>>
>> for you to fetch changes up to 53f9443da63db38212e784b0aa205881168757aa:
>>
>>   clk: mxs: replace imx23 clk_register_clkdev with clock DT lookup (2012-09-11 14:45:46 +0800)
>>
>> ----------------------------------------------------------------
>> mxs-clk-dt-lookup
>>
>> It replaces clk_register_clkdev in mxs clock driver with DT lookup.
>> The series depends on pull request mxs-dt-3.7 and Mike's clk branch
>> below.
>
> Pulled in as mxs/clk-dt-lookup, thanks!
>
> I also pulled in Mike's clk-3.7 branch as a dependency. Mike, this
> assumes that the branch is stable (which you've already mostly promised
> in the past).
>
> Please let us know if it isn't and/or if you prefer to just give us
> a shorter topic branch with the dependent commit to pull in instead.
>

clk-3.7 is stable.  I might merge the current clk-next into it soon,
but that's just a fast-forward.

Regards,
Mike

>
> -Olof
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
