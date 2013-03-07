From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Thu, 7 Mar 2013 11:25:42 -0800
Subject: [kvmarm] [GIT PULL v2] KVM/ARM Fixes for 3.9-rc1
In-Reply-To: <20130307190900.GB15854@amt.cnet>
References: <CAEDV+gLpqG0GxbCDoUqO2fdwpqLeEd_psaaFWzm2Xi829-zUTQ@mail.gmail.com>
 <f3db22097ee303991fccc64bbf863dd6@localhost>
 <CAEDV+g+ATCr3Hd+VjwLW7tgbJ9Cq4eaC49ZFO-1jB=grAVR49w@mail.gmail.com>
 <fd46d1c4746530d6c705dba843c848ea@localhost>
 <20130307190900.GB15854@amt.cnet>
Message-ID: <CAEDV+gL8gfqY05fqNRCKX642K9ZZihGrYe0DbxDu5hQWGRKsDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 7, 2013 at 11:09 AM, Marcelo Tosatti <mtosatti@redhat.com> wrote:
> On Thu, Mar 07, 2013 at 07:57:23AM +0100, Marc Zyngier wrote:
>> On Wed, 6 Mar 2013 20:40:00 -0800, Christoffer Dall
>> <cdall@cs.columbia.edu>
>> wrote:
>> > On Wed, Mar 6, 2013 at 7:54 PM, Marc Zyngier <marc.zyngier@arm.com>
>> wrote:
>> >> On Wed, 6 Mar 2013 16:31:48 -0800, Christoffer Dall
>> >> <cdall@cs.columbia.edu>
>> >> wrote:
>> >>
>> >> Hi Christoffer,
>> >>
>> >>>
>> >>> Please pull these KVM/ARM fixes mostly centered around preparation for
>> >>> Marc's ARMv8 KVM work.
>> >>
>> >> Can we please hold on that for a while? asm-offset.c is usually a
>> >> candidate for merge conflicts as people start pushing patches post
>> merge
>> >> window, and it would make sense to see what is happening in that space.
>> >>
>> > Sure, when would you see this happen exactly?
>>
>> Usually, by -rc5 we have a pretty good idea of what is going in. Also,
>> putting things into -next is a good way to detect potential problems.
>>
>> Oh, and keeping linux-arm-kernel into the loop. Most ARM developers don't
>> follow the KVM lists.
>>
>>         M.
>
> Mark, can you please be more verbose on the reason for this request?
>
> Christoffer, patches which are not causing merge conflicts can be
> integrated (note that the merge window exists so that development code
> can sit on a development branch and be tested before integration).
>
> After the merge window has closed, patches whose purpose is to stabilize
> the code base are supposed to be integrated, and development code queued
> for the next merge window.
>

Understood and agreed. Since the patches I sent a pull request for
fixes code (although not bugs) and are trivial and would not cause
breakage, I think they should be merged into kvm/master.  This is
anyhow going to be a judgement call in the future, and I can certainly
adjust my evaluations as we go along in the future, but I don't see
the harm in honoring this pull request.

-Christoffer
