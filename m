From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 18 Jul 2017 09:14:53 +0200
Subject: [PATCH resend] Documentation: arm: Replace use of virt_to_phys
 with __pa_symbol
In-Reply-To: <20170717212025.GM31807@n2100.armlinux.org.uk>
References: <1500298768-13262-1-git-send-email-geert+renesas@glider.be>
 <20170717134445.22a1b00d@lwn.net>
 <20170717212025.GM31807@n2100.armlinux.org.uk>
Message-ID: <CAMuHMdUNKJzRfe-_fYUj3wQaL=nA_E-Q60ENJG5ZiVJ+fXg4UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Jul 17, 2017 at 11:20 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Mon, Jul 17, 2017 at 01:44:45PM -0600, Jonathan Corbet wrote:
>> On Mon, 17 Jul 2017 15:39:28 +0200
>> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>>
>> > All low-level PM/SMP code using virt_to_phys() should actually use
>> > __pa_symbol() against kernel symbols.  Update the documentation to move
>> > away from virt_to_phys().
>> >
>> > Cfr. commit 6996cbb2372189f7 ("ARM: 8641/1: treewide: Replace uses of
>> > virt_to_phys with __pa_symbol")
>>
>> I was kind of hoping for an ack from somebody on this, but, four months
>> later, I'll take the absence of complaints as being enough.  Applied,
>> thanks.
>
> Maybe those who contributed Documentation/arm/firmware.txt should
> have responded, seems that was Tomasz Figa <t.figa@samsung.com>
> who isn't even on the Cc list for this...

Ah, get_maintainer.pl didn't report Tomasz' Samsung email address, which
bounces for sure ;-)

> Can't blame people who aren't copied with the patch for not
> responding.

I did copy the people responsible for the __pa_symbol conversion.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
