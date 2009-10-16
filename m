From: alex@digriz.org.uk (Alexander Clouter)
Date: Fri, 16 Oct 2009 12:50:57 +0100
Subject: arm / kirkwood (openrd): cpu_idle
References: <200910151352.41991.dk-arm-linux@gmx.de>
	<20091015121022.GC26774@twin.sascha.silbe.org>
	<200910151428.27691.dk-arm-linux@gmx.de>
	<ad9478410910150556h346c1042l48589843087e6fba@mail.gmail.com>
Message-ID: <1a3mq6-ga5.ln1@chipmunk.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joel Stanley <joel@jms.id.au> wrote:
>
> On Thu, Oct 15, 2009 at 22:58, Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:
>>
>> Am Donnerstag 15 Oktober 2009 14:10:22 schrieb Sascha Silbe:
>
>>> On Thu, Oct 15, 2009 at 01:52:41PM +0200, Dieter Kiermaier wrote:
>>>
>>> > But it looks like that in rc4 something has changed so the patch
>>> > didn't apply without errors.
>>> It was quite easy to resolve (even though I don't understand any of the
>>> touched code), see [1] for a rebased patch.
> 
> I can confirm that the patch fixes the issue; I have been testing for
> 48 hours on an openrd-client without seeing the WARNING.
> 
>>> I'm wondering why it wasn't merged upstream yet, though.
>>
>> I'm wondering, too.
> 
> Agreed.  What can we do to help it on it's way?
> 
I guess someone could add a bunch of Tested-By's to the LKML posting.

http://patchwork.kernel.org/patch/50728/

Cheers

-- 
Alexander Clouter
.sigmonster says: "We live, in a very kooky time."
                  		-- Herb Blashtfalt
