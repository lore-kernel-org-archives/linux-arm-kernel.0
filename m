From: olof@lixom.net (Olof Johansson)
Date: Mon, 18 Nov 2013 13:25:00 -0800
Subject: ACPI vs DT at runtime
In-Reply-To: <528A7BFD.4020303@jonmasters.org>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <5289A356.4060004@jonmasters.org> <5289A4F3.5040203@jonmasters.org>
 <20131118192552.GD5886@quad.lixom.net>
 <528A7BFD.4020303@jonmasters.org>
Message-ID: <CAOesGMj+Mry2TtyDfd+NSM3Z9=NUA=TE145FnVDTWuR+45_nog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 12:43 PM, Jon Masters <jonathan@jonmasters.org> wrote:
> On 11/18/2013 02:25 PM, Olof Johansson wrote:
>> On Mon, Nov 18, 2013 at 12:26:11AM -0500, Jon Masters wrote:
>>> On 11/18/2013 12:19 AM, Jon Masters wrote:
>>>
>>>> It's going to be a messy thing to even attempt. Look, I wish we had a
>>>> time machine and could have done this whole thing years ago, but I'm not
>>>> sure it would have gone differently. ACPI is something a lot of people
>>>> emotionally hate. In the Enterprise space myself and others *need* it
>>>> (along with UEFI) to have a scalable solution that doesn't result in an
>>>> onslaught of customer support calls, which a non-standards body backed
>>>> moving target of DTB will do. And besides all of the big boys are going
>>>> to be using ACPI whether it's liked much or not.
>>>
>>> A while ago I mentioned producing a series of requirements that
>>> articulates what Red Hat thinks an ARMv8 server looks like. Suffice it
>>> to say that such requirements do in fact exist, and will be made
>>> available in the not too distant future as part of another doc.
>>
>> It's nice that there's an unpublished document with a RedHat logo on it
>> somewhere that mandates what we, the kernel project, is going to do.
>>
>> I thought both RedHat and you personally knew that we don't do things
>> that way in the kernel, Jon. Published or not.
>
> Olof, I understand completely. My hands are unfortunately tied and it's
> not of my making (or my employer) on this front. In the ARM space, there
> are a lot of entities involved when it comes to anything at all, and you
> know what the NDA situation is like. I am pushing to get a few things
> out there for broader consumption.

No, I don't think you understand. Or at least, your email is not reflecting it.

It's not whether the document is public or not that is the real
problem. The real problem is the claim that you have a platforms
requirements document that is built upon unmerged features in the
upstream kernel. Unless RedHat is willing to carry that functionality
in their own kernel instead -- if so, RedHat is of course free to
mandate whatever they want to.


-Olof
