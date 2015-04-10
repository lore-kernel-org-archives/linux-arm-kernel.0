From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 9 Apr 2015 20:36:44 -0700
Subject: [PATCH v6 3/6] regulator: axp20x: prepare support for multiple
 AXP chip families
In-Reply-To: <20150409203634.GD6023@sirena.org.uk>
References: <1427868203-7486-1-git-send-email-wens@csie.org>
 <1427868203-7486-4-git-send-email-wens@csie.org>
 <CAGb2v66zbATMHY5SgZLs3RCoRETroSh5nC3h4TXRLm5UAbythw@mail.gmail.com>
 <20150409195502.GC6023@sirena.org.uk>
 <CAGb2v66B-__CRcoyoiebNUs-=UBWxP4kQBGVpO4R_FMUSh7MKw@mail.gmail.com>
 <20150409203634.GD6023@sirena.org.uk>
Message-ID: <CAGb2v64hsRV1S1E=9t1Gezx-HPT_mzVNc8p7hy_4jcoj5-1bsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 9, 2015 at 1:36 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Apr 09, 2015 at 01:30:25PM -0700, Chen-Yu Tsai wrote:
>> On Thu, Apr 9, 2015 at 12:55 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Someone would need to resend them to me as I've deleted them and it
>> > appears that this is a part of a series - are you sure there are no
>> > dependencies?
>
>> The 2 patches only touch drivers/regulator/axp20x-regulator.c.
>> Unless someone else is doing cleanup on them (AFAIK no one has),
>> there should be no problem.
>
> No header file dependencies?

The next patch (4/6) depends on mfd headers. That's why I'm asking
if the whole series, including the regulator patches, could go
through the mfd tree.

>> In any case, I will resend them after 4.1-rc1 if they aren't merged
>> by then.
>
> To be clear there is no chance they will be applied if they're not
> resent before the merge window.

Got it. I'll resend it with comments to clarify what I'm asking.

ChenYu
