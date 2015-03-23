From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 23 Mar 2015 16:43:09 -0700
Subject: [PATCH v2 0/2] ARM: dts: sunxi: Fix cpufreq instabilities
In-Reply-To: <20150321182035.GE2774@lukather>
References: <1426834160-10409-1-git-send-email-wens@csie.org>
 <20150321182035.GE2774@lukather>
Message-ID: <CAGb2v67vP-cSzOFk7s9O3b7+afa62zSpYT5asgbcvrAyfS5EPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 21, 2015 at 11:20 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Mar 20, 2015 at 02:49:18PM +0800, Chen-Yu Tsai wrote:
>> Hi Maxime,
>>
>> Here's v2 of the sunxi cpufreq dts fixes, aimed at 4.0.
>>
>> The first patch limits the Olimex A10-Lime to 912MHz, as a few people
>> reported on IRC that it was unstable at 1008MHz.
>>
>> The second patch removes the overclocking settings from sun[457]i dts,
>> so all the boards will be stable, regardless of whether regulators
>> were added or not.
>>
>> I would like to revisit this after the new OPP bindings are merged
>> and support added to cpufreq-dt.
>
> Applied both, thanks!

I see you applied them under sunxi/dt-for-4.1.
Shouldn't we merge them for 4.0 fixes?

ChenYu
