From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 Jul 2014 12:09:44 +0100
Subject: [RFC V1] devicetree: Dialog Semiconductor consolidate existing
 vendor prefixes to standardise on 'dlg'
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7D0B269FA@SW-EX-MBX02.diasemi.com>
References: <201407141616.s6EGG7uK022881@swsrvapps-01.diasemi.com>
 <20140714162101.GM26465@leverpostej>
 <6ED8E3B22081A4459DAC7699F3695FB7D0B269FA@SW-EX-MBX02.diasemi.com>
Message-ID: <20140715110944.GY26465@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 11:07:57AM +0100, Opensource [Steve Twiss] wrote:
> 
> 
> On 14 July 2014 17:21, Mark Rutland wrote:
> >From: Mark Rutland [mailto:mark.rutland at arm.com]
> >
> >On Mon, Jul 14, 2014 at 05:07:20PM +0100, Opensource [Steve Twiss] wrote:
> >> From: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
> >>
> >> This patch series updates the device tree vendor prefix for
> >> Dialog Semiconductor
> >>
> >> Various methods are currently used throughout the kernel: 'diasemi',
> >> 'dialog' and 'dlg'. Others have also been suggested.
> >>
> >> This patch set aims to consolidate the usage of the vendor prefix to
> >> use a common standard. The prefix 'dlg' is used.
> >>
> >> This e-mail is in response to the previous thread here:
> >>
> >> - https://lkml.org/lkml/2014/6/11/262
> >
> >In that response, Rob pointed out the old forms should be marked
> >deprecated, but the patch seems to outright remove them.
> >
> >Are we sure this doesn't break an existing DTB anywhere?
> >
> >Thanks,
> >Mark.
> 
> Hi Mark,
> 
> Rob said that the old forms should be marked as deprecated, but I didn't
> deprecate any "dialog" or "diasemi" entries in this patch because I have
> only made two types of change:
> 
> (1) definitions of "diasemi" or "dialog" that have not been used in the kernel;
> (2) definitions of "diasemi" or "dialog" that are incompatible with existing driver code.
> 
> In both of these cases they cannot affect any working DTB.

Ok, that sounds fine then. That just wasn't immediately obvious.

Could you please note those facts in the commit message when you next
post?

> Actually -- I will need to resend a V2 to this patch because I did miss out two
> files for DA9210 which reference the unused compatible flag "diasemi" and I
> might as well fix those while I am doing this change.
> 
> I will resend those changes all my "working" in my next patch RFC V2.

That sounds fine to me.

Cheers,
Mark.
