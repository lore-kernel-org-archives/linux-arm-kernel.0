From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 2 Jun 2016 22:14:48 +0800
Subject: [PATCH resend v2 1/6] regulator: axp20x: support AXP809 variant
In-Reply-To: <20160602132536.GI2282@sirena.org.uk>
References: <1464711804-19256-1-git-send-email-wens@csie.org>
 <1464711804-19256-2-git-send-email-wens@csie.org>
 <20160531173647.GJ29837@sirena.org.uk>
 <CAGb2v67eVjNnON1pAPKMSMgq83sk6u7Q53qDs0dTEbhyTAR_gA@mail.gmail.com>
 <20160602102742.GG2282@sirena.org.uk>
 <CAGb2v64sh_2ScP-WQioWe9su6Hx8wjyjMHVLE6Q1q9zSHZohCA@mail.gmail.com>
 <20160602132536.GI2282@sirena.org.uk>
Message-ID: <CAGb2v660su71SHOgF4ZEdFNz=HyJQxe+Y+wvD-cYTHCL5ZdhgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 2, 2016 at 9:25 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jun 02, 2016 at 07:05:22PM +0800, Chen-Yu Tsai wrote:
>> On Thu, Jun 2, 2016 at 6:27 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> >> The mfd patches this one depended on were pushed around a week before
>> >> the merge window, about a month after you reviewed, merged, then backed
>> >> out this patch. There was no immutable branch either.
>
>> > Why did it get backed out?
>
>> Because of missing compile dependencies on the mfd bits, which weren't
>> merged yet.
>
> No, what I'm asking is why didn't it get merge along with the MFD bits?

I had asked Lee to push an immutable branch for you to merge this patch
on top of. Obviously that did not come through. Lee did not merge this
patch with the mfd bits either.

So unfortunately I do not have a proper answer for you. Sorry.


Regards
ChenYu
