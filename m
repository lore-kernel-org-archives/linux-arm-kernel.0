From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 31 Oct 2013 10:45:08 -0500
Subject: [PATCH RFC] ARM: dts: imx6qdl: make pinctrl nodes board specific
In-Reply-To: <20131031102908.GX16735@n2100.arm.linux.org.uk>
References: <1382672542-16100-1-git-send-email-shawn.guo@linaro.org>
 <20131031080326.GK24559@pengutronix.de>
 <20131031102908.GX16735@n2100.arm.linux.org.uk>
Message-ID: <CAHCPf3vTcu9RCk8=9MUs4nkyJ-8jevh5koxfzdLzE5+qM0ZspQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I suggested this to Shawn a couple weeks ago and got a bit of pushback.

There's probably a ton more to do in this regard to keep the DT
per-board more concise, but this drops tree size by a respectable
amount on i.MX51 too (just on a tree I have internally, it's something
like 8.5KiB) and I can't see any redundant data in the ones he
patched.

I can follow this up with i.MX51/i.MX53 if nobody is already doing that..

Acked-by: Matt Sealey <neko@bakuhatsu.net>

On Thu, Oct 31, 2013 at 5:29 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Oct 31, 2013 at 09:03:26AM +0100, Sascha Hauer wrote:
>> So:
>>
>> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
>
> Ok, I'll wait for this to hit mainline before re-spinning the Carrier-1
> DT files.  That's going to upset those who want to see Carrier-1 support
> in mainline at the next merge window (like Olof) and out mainline support
> for this board into 2014, but I don't see any other alternative.
