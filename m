From: ats@offog.org (Adam Sampson)
Date: Sat, 10 Oct 2015 13:49:45 +0100
Subject: [linux-sunxi] [PATCH] ARM: dts: sun7i: Correct USB regulators on
 pcDuino v3 Nano
In-Reply-To: <CAGb2v67_dSCL2JP1D5SDaqSF3B4KDMKZUJcZ8QLHgFtcO8Bzug@mail.gmail.com>
 (Chen-Yu Tsai's message of "Sat, 10 Oct 2015 10:17:52 +0800")
References: <1444441679-4802-1-git-send-email-ats@offog.org>
 <CAGb2v67_dSCL2JP1D5SDaqSF3B4KDMKZUJcZ8QLHgFtcO8Bzug@mail.gmail.com>
Message-ID: <y2amvvqga6u.fsf@cartman.at.offog.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chen-Yu Tsai <wens@csie.org> writes:

> Since Siarhei spotted the issue, maybe add a Reported-by tag where credit
> is due?

Will do.

>>  &reg_ahci_5v {
>> +       pinctrl-names = "default";
[twice]
>
> This is already in sunxi-common-regulators.dtsi.
> No need to add it again.

OK -- fixed. v2 incoming.

Thanks,

-- 
Adam Sampson <ats@offog.org>                         <http://offog.org/>
