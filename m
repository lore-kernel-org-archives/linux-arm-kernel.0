From: neko@bakuhatsu.net (Matt Sealey)
Date: Tue, 5 Nov 2013 16:00:51 -0600
Subject: [PATCH RFC] ARM: dts: imx6qdl: make pinctrl nodes board specific
In-Reply-To: <20131105020611.GD19770@S2101-09.ap.freescale.net>
References: <1382672542-16100-1-git-send-email-shawn.guo@linaro.org>
 <20131031080326.GK24559@pengutronix.de>
 <20131031102908.GX16735@n2100.arm.linux.org.uk>
 <CAHCPf3vTcu9RCk8=9MUs4nkyJ-8jevh5koxfzdLzE5+qM0ZspQ@mail.gmail.com>
 <20131101083332.GB10324@S2101-09.ap.freescale.net>
 <CAHCPf3vhyjTnqHXYRj49AL80Z_jGd4LbaRfySjK-=Axkk4FNqA@mail.gmail.com>
 <20131105020611.GD19770@S2101-09.ap.freescale.net>
Message-ID: <CAHCPf3tjH-ptig-gKtFkChGZkYzv24qi022Qk4rvy236+QBF4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 4, 2013 at 8:06 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Mon, Nov 04, 2013 at 04:50:01PM -0600, Matt Sealey wrote:
>> On Fri, Nov 1, 2013 at 3:33 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> > On Thu, Oct 31, 2013 at 10:45:08AM -0500, Matt Sealey wrote:
>> >> I suggested this to Shawn a couple weeks ago and got a bit of pushback.
>> >>
>> >> There's probably a ton more to do in this regard to keep the DT
>> >> per-board more concise, but this drops tree size by a respectable
>> >> amount on i.MX51 too (just on a tree I have internally, it's something
>> >> like 8.5KiB) and I can't see any redundant data in the ones he
>> >> patched.
>> >>
>> >> I can follow this up with i.MX51/i.MX53 if nobody is already doing that..
>> >
>> > I'm taking care of them as a move of while IMX family.
>>
>> I'd quite like to push the Efika MX trees at the state they're at,
>> sometime in the near future; if this work is going to take a while
>> could I just do it and submit it and see your objections?
>
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/277649
>
> It's on my for-next branch for testing now.


Got it. Will jiggle everything to suit and just base against that.

Thanks,
Matt Sealey <neko@bakuhatsu.net>
