From: lkcl@lkcl.net (Luke Kenneth Casson Leighton)
Date: Wed, 5 Jun 2013 22:15:08 +0100
Subject: getting allwinner SoC support upstream (was Re: Uploading linux
 (3.9.4-1))
In-Reply-To: <CAKON4OxDD5orX2w-_+d5kawTGXbE3KKj2QLERo9m7=NiUSXhgQ@mail.gmail.com>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <CAKON4OxDD5orX2w-_+d5kawTGXbE3KKj2QLERo9m7=NiUSXhgQ@mail.gmail.com>
Message-ID: <CAPweEDzDC87KmOQ=0hyPcjPtPsRuXHxNTs97vbEqVNNnix69rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[i've just received word, please remove debian-release from discussions!]

On Wed, Jun 5, 2013 at 9:46 PM, jonsmirl at gmail.com <jonsmirl@gmail.com> wrote:

> Why don't you try converting the sunxi code over to device tree?

ok.  perhaps i wasn't clear.  whatever is proposed has to be be
acceptable to allwinner, and i'm looking for proposals that i can put
to them, i.e. i am going to act as the communications channel to them.

what we do not want to happen is that they see upstream patches being
submitted, they merge them into their internal tree (which to date has
had zero upstream changes: they're currently only just getting round
to doing 3.4 as we speak), and they *completely* ignore *absolutely
everything* that's being done by the community, duplicating yet
another set of device drivers (named drivers/*/sun8i_* and so on).

> I don't
> think it will be as hard as you may think it is. Start off by mapping the
> existing fex syntax into a DTS file. Send your DTS file to
> devicetree-discuss to get help with the correct syntax. Once this DTS
> template is constructed you can write a program to convert any fex file into
> it.

 this proposal is a start: however what you have to bear in mind is
that you now have to convince a very busy company that it is in their
best interests to disrupt their schedule, to drop their existing
working practices, to tell all their customers "please stop using the
existing tools and please use these ones instead".

 you also need to convince the creators of the proprietary
firmware-flashing tools "livesuite" and "phoenix" to *also* convert
their tools over to the new proposed idea.

 so if that is to truly be accepted, it has to be framed in such a way
that it will be clearly of financial benefit to the SoC vendor.

 can you provide such a supporting argument which would convince
allwinner to accept the modifications to their working practices that
you propose?


> Device tree on ARM's goal is to achieve a single kernel across vendors, not
> just a single kernel for a single vendor.

 you'll be aware that i've mentioned a number of times and have
discussed at some length why this is a goal that is completely
impossible to achieve [*1].  sadly.

l.

[*1] without a hardware-level redesign i.e. hardware standardisation that is.
