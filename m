From: khilman@ti.com (Kevin Hilman)
Date: Tue, 31 Jan 2012 13:59:20 -0800
Subject: [PATCH v2 00/19] ARM: OMAP3+: SmartReflex: bugfixes
In-Reply-To: <20120131173344.GL9339@atomide.com> (Tony Lindgren's message of
 "Tue, 31 Jan 2012 09:33:44 -0800")
References: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
 <20120131170830.GJ9339@atomide.com>
 <CAN5iSWo9+P=tC5Uq_bZ+Js_QPpGTn=Q6f5ecgiehRvT2E5+Diw@mail.gmail.com>
 <20120131172008.GK9339@atomide.com>
 <CAORVsuWELB2rt3Vs-5oHFyXCRDUPXSpqOJo26cH+_i3Y0hdraQ@mail.gmail.com>
 <20120131173344.GL9339@atomide.com>
Message-ID: <87fwevleiv.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Jean Pihet <jean.pihet@newoldbits.com> [120131 08:53]:
>> On Tue, Jan 31, 2012 at 6:20 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Pihet-XID, Jean <j-pihet@ti.com> [120131 08:44]:
>> >> Hi Tony,
>> >>
>> >> On Tue, Jan 31, 2012 at 6:08 PM, Tony Lindgren <tony@atomide.com> wrote:
>> >> > * Jean Pihet <jean.pihet@newoldbits.com> [120131 01:28]:
>> >> >> Integrate the latest SmartReflex bufixes from Felipe Balbi [1] and
>> >> >> Nishant Menon [2], plus misc bugfixes.
>> >> >
>> >> > We should move this to live under drivers somewhere. So
>> >> Yes that is the plan, eventually.
>> >>
>> >> > I'd like to see just minimal cleanup in the current location,
>> >> > then move it to drivers before further patching.
>> >> >
>> >> > Is this the minimal cleanup needed before doing that, or
>> >> > what's your plan regarding moving it to drivers?
>> >> I would like to clean-up a few things and integrate well known
>> >> bugfixes before the actual move to drivers/. Doing the opposite
>> >> generates a rather big patch set (45+ patches to start with).
>> >>
>> >> What do you think?
>> >
>> > OK fine with me. So would the next patch after this series move
>> > it to drivers then?
>> The move to drivers requires some preparation in order to isolate the
>> SR code from the other OMAP PM code. A patch set containing ~20
>> patches is needed for that, the very last one being the actual move
>> between directories.
>> 
>> Is that Ok to you?
>
> OK, let's plan on putting all the smartreflex stuff into a separate
> branch then. If some changes are needed to the PM code, those should
> probably be applied first into Kevin's PM branch.

Tony, I'll queue up this series (after I get to reviewing them) as well
as the changes needed to the PM core code.  After that we'll be ready to
move.

Kevin
