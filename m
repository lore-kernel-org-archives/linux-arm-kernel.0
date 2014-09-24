From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 24 Sep 2014 09:38:47 -0600
Subject: [PATCH v12 00/12] Support for creating generic PCI host bridges
 from DT
In-Reply-To: <20140924142317.GC1994@e106497-lin.cambridge.arm.com>
References: <1411498874-9864-1-git-send-email-Liviu.Dudau@arm.com>
 <20140923215435.GD27117@google.com> <20140923224810.GA32643@bart.dudau.co.uk>
 <CAErSpo5PBXSUeU_LP2m=9jxibmqxreL4tEeHBsc5To7D=_bAJA@mail.gmail.com>
 <CAL_Jsq+U=1JT0qqZgb=aR66Q4NYDyzOogspOmmpsp61pE+aCUg@mail.gmail.com>
 <20140924142317.GC1994@e106497-lin.cambridge.arm.com>
Message-ID: <CAErSpo5AtS3V5KE7+vLeatSQBW0OQqjRByMxj4j8GpvuxwYt_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 8:23 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> On Wed, Sep 24, 2014 at 02:30:37PM +0100, Rob Herring wrote:
>> On Tue, Sep 23, 2014 at 6:00 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> > On Tue, Sep 23, 2014 at 4:48 PM, Liviu Dudau <liviu@dudau.co.uk> wrote:
>> >> ...
>> >> While the next immediate target is converting pci-host-generic.c, pci-imx6.c
>> >> and probably pcie-designware.c to my series, I would like to ask you what
>> >> is your longer term plan. Now that I have got my head full of PCI code,
>> >> I have some ideas but feel that meeting with you and all those involved
>> >> in core PCI support would be a better venue than sending emails back and
>> >> forth. When is your next plan to attend a Linux conference?
>> >
>> > That would be nice.  Unfortunately, I don't know what the next
>> > conference will be yet.
>>
>> Perhaps an irc meeting or Google hangout. These have been happening on
>> several areas like DT and ARM KVM.
>
> I'm open to the idea. I don't know if there is a recurring one already for
> PCI or how Bjorn has been handling future planning previously.

There is no periodic PCI meeting, and I don't have any formal future
planning.  We had PCI microconferences at the last couple Linux
Plumbers conferences, but we didn't plan one for this year because it
has been hard to get topic proposals (and I'm not going to be in
D?sseldorf).

I would attend an IRC or hangout meeting, of course.  For myself, I
think it would be most useful if it were to follow up on
previously-posted patches, so I'd have a chance to look them over
first, and then have the opportunity in a meeting to talk in more
detail.  If a meeting is a forum for abstract thinking about what we
might do, it's hard for me to respond meaningfully in real time
because I need time to research and explore things.

Bjorn
