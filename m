From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 4 Jan 2012 12:12:07 +0100
Subject: [PATCH] ARM: imx6q: add support for IRAM
In-Reply-To: <20120103124136.GQ2914@n2100.arm.linux.org.uk>
References: <1324898123-13973-1-git-send-email-jason.chen@linaro.org>
 <20111226134129.GA9014@S2100-06.ap.freescale.net>
 <20120103091015.GD2914@n2100.arm.linux.org.uk>
 <20120103124355.GC13477@S2100-06.ap.freescale.net>
 <20120103124136.GQ2914@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZ6q2T5aV7GncT+Uk2p69zH0RKDFzpAPTnn9_n=Wm5a2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 3, 2012 at 1:41 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jan 03, 2012 at 08:43:56PM +0800, Shawn Guo wrote:
>> On Tue, Jan 03, 2012 at 09:10:15AM +0000, Russell King - ARM Linux wrote:
>> > Why is this even specific to fsl? ?Isn't it something that could be
>> > specified in a totally generic way?
>> >
>> > As I showed with my original set of sram patches, there is not much
>> > specific about this on-board RAM: what is specific is how a SoC uses
>> > it, and that's up to the rest of the SoC code.
>> >
>> As I have not seen any news/updates about the sram consolidation series
>> since May, I did not bring up it here. ?So what's the state of the
>> series? ?If it shows up on some stable branch, we would be happy to
>> base the work here on it.
>
> I have no idea; as I've already said, I lost total interest in it.
>
> What I _am_ saying though is that rather than defining some platform
> specific bindings and continuing that idiotic state of affairs, we
> have the chance to do things properly now: define a standard set of
> DT bindings to describe on-board SRAM.
>
> That's something which can be done with or without the sram
> consolidation stuff.

I second this. It's just a piece of RAM, it should be described
the same way irrespective of system or even OS.

On-chip RAM is yet another area where platforms and their
maintainers sometimes think they are very different - just like
everyone else.

(This connects to the other IRAM patch floating on the list.)

Yours,
Linus Walleij
