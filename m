From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Wed, 25 Apr 2018 02:22:14 +0900
Subject: [PATCH 0/5] arm64: dts: renesas: r8a779xx: sort nodes
In-Reply-To: <20180424082443.svxfrb2lhzjh3g3z@verge.net.au>
References: <1524082480-18163-1-git-send-email-ykaneko0929@gmail.com>
 <20180423102658.ezofcrgzzwvzdfor@verge.net.au>
 <CAH1o70+1wfa1Vc1B_fjofhk4CALXtT-eyvXznDsDNypNOVfG1A@mail.gmail.com>
 <20180424082443.svxfrb2lhzjh3g3z@verge.net.au>
Message-ID: <CAH1o70+o2-Jb=s5GOkn1e0BJ8yLpz=rAowYBcgBD80m34u4bYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon-san,

2018-04-24 17:24 GMT+09:00 Simon Horman <horms@verge.net.au>:
> On Tue, Apr 24, 2018 at 02:31:40AM +0900, Yoshihiro Kaneko wrote:
>> Hi Simon-san,
>>
>> 2018-04-23 19:26 GMT+09:00 Simon Horman <horms@verge.net.au>:
>> > On Thu, Apr 19, 2018 at 05:14:35AM +0900, Yoshihiro Kaneko wrote:
>> >> Sort nodes of the R-Car M3-N (r8a77965), V3M (r8a77970) and D3 (r8a77995) DTs.
>> >>
>> >> This is part of an ongoing effort to provide consistent node
>> >> order in the DT of Renesas SoCs to improve maintainability.
>> >>
>> >> This should not have any run-time effect.
>> >>
>> >> Based on the devel branch of Simon Horman's renesas tree.
>> >>
>> >> Yoshihiro Kaneko (5):
>> >>   arm64: dts: renesas: r8a77995: sort subnodes of the root node
>> >>   arm64: dts: renesas: r8a77995: sort subnodes of the soc node
>> >>   arm64: dts: renesas: r8a77965: sort subnodes of the root node
>> >>   arm64: dts: renesas: r8a77965: sort subnodes of the soc node
>> >>   arm64: dts: renesas: r8a77970: sort subnodes of the soc node
>> >
>> > Thanks, applied.
>> >
>> > There ware a few nodes added to r8a77970 between when you made
>> > this patchset and when I applied it. I think the r8a77970 is still
>> > sorted as desired. Could you double-check once I push a devel
>> > branch later today?
>>
>> Yes, will do.
>
> Thanks, you should now be able to check renesas-devel-20180423-v4.17-rc2

fcpvd0 should be after vspd0?
It seems good to me except the above.
