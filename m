From: luke.leighton@gmail.com (luke.leighton)
Date: Wed, 5 Jun 2013 23:47:13 +0100
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <1370469574.18839.33.camel@localhost>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <CAKON4OxDD5orX2w-_+d5kawTGXbE3KKj2QLERo9m7=NiUSXhgQ@mail.gmail.com>
 <51AFA6DD.3000202@wwwdotorg.org>
 <CAPweEDz=hFxXW3XF9CSNZpEFSjayb5an1E8Xze1_uQcCZONVxg@mail.gmail.com>
 <1370469574.18839.33.camel@localhost>
Message-ID: <CAPweEDxMpeJc-w=Yd7d2OT=UisRBp2rxf-MPMDUCOG3EyJz1GQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 5, 2013 at 10:59 PM, Henrik Nordstr?m
<henrik@henriknordstrom.net> wrote:

>>  .... and then there's the boot0 and boot1 loaders, these *do* have

> no, these are not tiny. boot0 is 24KB to fit the initial embedded SRAM
> (not cache), but boot1 is on pair with u-boot in size and runs from
> DRAM.

 btw, please listen to henrik: he knows what he's talking about, as
you can see :)   henrik, thank you for correcting my technical
misunderstandings, i'll try to remember them and not propagate
incorrect stuff.

>>  so the point is: if anyone wishes me to propose to allwinner that
>> they convert over to devicetree, or any other proposal which involves
>> significant low-level changes to their working practices that could
>> potentially have a massive knock-on effect onto their
>> multi-million-dollar clients, it had better be a damn good story.
>
> Calm down.

 i am - honest!  yes it's a little past my bed-time, but hey...

> It isn't really a significant difference to them outside of
> the kernel. They do not need to change any of their configuraiton
> methods, only a small toolchain change in how the resultig images are
> built to have a corresponding device tree built.

 henrik, jon (smirl), can i ask you both a favour?  could you write
something up, preferably short, that i could put forward to allwinner?
 describing what's needed, who would need to do what and so on.


> But it is a fair bit of one-time changes kernel side. And some
> scratching to figure out how to use/improve/ignore the stuff being
> mainlined.

 i still also - really - need a good justification for this.
something which helps explain clearly what the immediate or perhaps
strategic benefits would be to allwinner, as to why they should accept
such changes.   i cannot emphasise enough how important that is.

 if someone can please help come up with a good justification as to
why allwinner should change their working practices, that would be
enormously helpful i feel, to solving this issue.

 otherwise we are stuck in the current situation which nobody really
likes.  i'm inviting you - linux kernel developers - i'm giving you an
opportunity to *fix* things.  you have 2 weeks to come up with a
solution, which can be presented in a simple format.  that's the
window of opportunity.

l.
