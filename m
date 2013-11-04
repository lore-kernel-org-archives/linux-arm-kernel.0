From: neko@bakuhatsu.net (Matt Sealey)
Date: Mon, 4 Nov 2013 16:50:01 -0600
Subject: [PATCH RFC] ARM: dts: imx6qdl: make pinctrl nodes board specific
In-Reply-To: <20131101083332.GB10324@S2101-09.ap.freescale.net>
References: <1382672542-16100-1-git-send-email-shawn.guo@linaro.org>
 <20131031080326.GK24559@pengutronix.de>
 <20131031102908.GX16735@n2100.arm.linux.org.uk>
 <CAHCPf3vTcu9RCk8=9MUs4nkyJ-8jevh5koxfzdLzE5+qM0ZspQ@mail.gmail.com>
 <20131101083332.GB10324@S2101-09.ap.freescale.net>
Message-ID: <CAHCPf3vhyjTnqHXYRj49AL80Z_jGd4LbaRfySjK-=Axkk4FNqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 1, 2013 at 3:33 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Thu, Oct 31, 2013 at 10:45:08AM -0500, Matt Sealey wrote:
>> I suggested this to Shawn a couple weeks ago and got a bit of pushback.
>>
>> There's probably a ton more to do in this regard to keep the DT
>> per-board more concise, but this drops tree size by a respectable
>> amount on i.MX51 too (just on a tree I have internally, it's something
>> like 8.5KiB) and I can't see any redundant data in the ones he
>> patched.
>>
>> I can follow this up with i.MX51/i.MX53 if nobody is already doing that..
>
> I'm taking care of them as a move of while IMX family.

I'd quite like to push the Efika MX trees at the state they're at,
sometime in the near future; if this work is going to take a while
could I just do it and submit it and see your objections?

I have no merge deadline like Russell, but I would like to put some
closure on some parts of my local tree and sync upstream. My Trello
cards are getting unmanageable ;)

Thanks,
Matt Sealey <neko@bakuhatsu.net>
