From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Thu, 21 Mar 2013 11:37:25 +0100
Subject: [PATCH v3 0/9] refactoring for mask_cache
In-Reply-To: <alpine.LFD.2.02.1303202222340.22263@ionos>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com><1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com><20130319100352.GB2419@localhost><20130319110620.GO13280@titan.lakedaemon.net><51484793.5020102@keymile.com><20130319114430.GP13280@titan.lakedaemon.net>
 <20130319115615.GR13280@titan.lakedaemon.net> <5149F48D.3030706@keymile.com>
 <alpine.LFD.2.02.1303202222340.22263@ionos>
Message-ID: <514AE2E5.8020700@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

first of all thanks for your patience.

On 03/20/2013 10:42 PM, Thomas Gleixner wrote:
> On Wed, 20 Mar 2013, Gerlando Falauto wrote:
>> On 03/19/2013 12:56 PM, Jason Cooper wrote:
>>> On Tue, Mar 19, 2013 at 07:44:31AM -0400, Jason Cooper wrote:
>
>> 3) Jason, did you mean you would pull it to
>> http://git.infradead.org/users/jcooper/linux.git? Shall I change the SOB lines
>> and resubmit? Or should I submit it somewhere else instead?
>
> That needs to go through my tree, really. And please just post it to
> LKML with the relevant people CC'ed.

So drop linux-kernel-arm?

>> 4) About submitting to -stable, I guess it wouldn't make any sense until it
>> gets included upstream
>
> Right. Though I'm a bit concerned about the amount of change
> involved. So it's simpler to do:
>
> Cc: <stable@vger.kernel.org> # simple resolution will be sent in reply

You mean per-patch (in the SOB area)? Or just in the cover letter? 
[Since when does the cover letter have a SOB area?]
Or just adding it as a plain "Cc:" recipient?
In any case, before waiting for mainstream inclusion?

I'm sorry for such stupid questions, but I'm getting even more confused...

> Then let the people who have this problem reply on that patch series
> with a simple revert of that generic_chip() conversion commit
> concering their particular subarchitecture instead of forcing a
> nightmare of complex (and maybe untested) changes onto stable.

I think I understand the idea, though you've lost me completely as far 
as the process is concerned...

A pointer to a FMTR (assuming there is one that I could be RTFM-ed to) 
would be very much appreciated. Sorry again for my newbieness.

Thanks again!
Gerlando
