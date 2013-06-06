From: olof@lixom.net (Olof Johansson)
Date: Thu, 6 Jun 2013 08:05:08 -0700
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <20130606140250.GA4839@thunk.org>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <1370475609.20454.44.camel@localhost>
 <CAPweEDwS3tR=wh-bZJb3vqR8fVQra=3XxDitowGRdH9c7WRfmQ@mail.gmail.com>
 <1733666.lHUBcfUXq9@flatron>
 <CAPweEDzYLDzh_-OWU61dtVhajZ40QpQgZKHFYDsh3FgF=r9_ag@mail.gmail.com>
 <20130606140250.GA4839@thunk.org>
Message-ID: <CAOesGMgukawVUN978xQARwOWBEhVQQXCPKYQ2eua8yAVgH5HCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 6, 2013 at 7:02 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Thu, Jun 06, 2013 at 01:24:57PM +0100, luke.leighton wrote:
>> On Thu, Jun 6, 2013 at 1:01 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>
>> > I don't see any other solution here than moving all the Allwinner code to
>> > DT (as it has been suggested in this thread several times already), as
>> > this is the only hardware description method supported by ARM Linux.
>>
>>  i repeat again: please state, explicitly and unequivocably that you -
>> linux kernel developers - are happy that the reach of linux and
>> gnu/linux OSes is dramatically reduced due to this intransigent
>> position.
>
> But that's not a true statement.  You've said that Allwinner is
> perfectly happy to carry code out of tree, by constantly porting their
> hacks from mainline kernels.
>
> For some of their customers, this will be acceptable to them.  In
> those cases, Linux will still be in use.  Great!  So claiming that the
> reach of Linux will be "dramatically reduced" just is not a
> supportable position.
>
> For other (potential) customers, for whom mainline kernel support is
> critically important, they will choose other hardware solutions that
> are in the mainline kernel.
>
> I don't see the problem here.

This is all just a big storm in a cup. Mainline kernel support for
allwinner SoCs are already happening through hobby development by
Maxime Ripard and others. Allwinner are not yet actively
participating, but they're aware of it. The whole situation is a
non-issue.

If the vendor prefers to keep carrying their own code for a while,
they're free to. It makes more sense for them to move over to the
upstream code as they move forward with their kernel versions, but
they can do that on their own schedule.

We've seen all this before, it tends to turn out OK in the longer run.


-Olof
