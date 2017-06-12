From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 12 Jun 2017 15:25:25 +0200
Subject: [PATCH 46/58] clocksource/drivers: Add a new driver for the Atmel
 ARM TC blocks
In-Reply-To: <eada48f9-55b5-859d-d37e-4c9e938bc29d@microchip.com>
References: <20170530215139.9983-47-alexandre.belloni@free-electrons.com>
 <20170606152104.GC2345@mai> <20170606180559.pkrr7ux2qqnmsd6y@piout.net>
 <20170607141735.GH2345@mai> <20170607152750.tksmyf5p3oajbsac@piout.net>
 <20170607210848.GJ2345@mai> <20170607231715.ns2vcxza2eexnzjs@piout.net>
 <20170608074236.62924f01@bbrezillon> <20170608074446.GM2345@mai>
 <20170608101334.4e60aa4c@bbrezillon> <20170608084026.GB2244@mai>
 <eada48f9-55b5-859d-d37e-4c9e938bc29d@microchip.com>
Message-ID: <4c2a5425-acb4-c639-7f54-1dd933c44d03@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2017 14:54, Nicolas Ferre wrote:

[ ... ]

>> I like the 'chosen' approach with the nodes you are proposing below. Thanks for
>> the constructive suggestion. The binding description matches perfectly what we
>> are trying to achieve.
>>
>> Rob? what do you think?
> 
> I'm following this work from a distance but as we've just celebrated the
> 1st anniversary for this patch series (11 June 2016), I propose that we
> now make up our mind quickly. Everybody seem to be on the same page and
> willing to make this rework move forward.
> 
> In Microchip/Atmel we would like to actually use this TCB rework both
> internally and in our mainline work to avoid having to rely on our own
> out-of-tree implementation.
> 
> The newly-added samv7 cortex-M can't boot without this series and a use
> of our current cortex-A SoCs with TrustZone in Secure World (SWd) is not
> possible with current mainline code only. On these two examples, the
> current timer on which we rely, the PIT, is not present.
> 
> So you probably understand that more than one year without real progress
> begins to be a little bit frustrating for the AT91 users...

Nicolas,

who are you exactly blaming?

Are you surprised a 58 patches series, with a gazillion of Cc'ed people
posted awhile ago, is ignored?




-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
