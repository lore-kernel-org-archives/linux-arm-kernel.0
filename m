From: hemanthv@ti.com (Hemanth V)
Date: Tue, 28 Sep 2010 14:20:15 +0530 (IST)
Subject: [PATCH 1/7] pwm: Add pwm core driver
In-Reply-To: <F45880696056844FA6A73F415B568C69532DC2FA8F@EXDCVYMBSTM006.EQ1STM.loca
	l>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
	<1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
	<201009281114.31223.anarsoul@gmail.com>
	<F45880696056844FA6A73F415B568C69532DC2FA8F@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <63731.10.24.255.18.1285663815.squirrel@dbdmail.itg.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
>> On 28 of September 2010 10:40:42 Arun Murthy wrote:
>> > The existing pwm based led and backlight driver makes use of the
>> > pwm(include/linux/pwm.h). So all the board specific pwm drivers will
>> > be exposing the same set of function name as in include/linux/pwm.h.
>> > As a result build fails.
>>
>> Which build fails? One with multi-SoC support? Please be more specific.
> Sure will add this in v2.
>

Could you clarify for the benefit of all, which specific issues you are
trying to address with this patch series
