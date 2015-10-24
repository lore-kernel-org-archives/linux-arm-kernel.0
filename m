From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 24 Oct 2015 12:17:25 +0200
Subject: [GIT PULL] pxa for v4.4
References: <878u72zlif.fsf@belgarion.home> <20151023171539.GB2224@localhost>
Message-ID: <87d1w4wagr.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson <olof@lixom.net> writes:

> On Fri, Oct 16, 2015 at 09:00:40PM +0200, Robert Jarzmik wrote:
>> Hi Arnd, Kevin and Olof,
>> 
>> This is the pxa pull request for 4.4 cycle. It is mainly magician enhancement
>> and fixes. Could you please consider pulling ?
>> 
>> The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
>> 
>>   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
>> 
>> are available in the git repository at:
>> 
>>   https://github.com/rjarzmik/linux.git pxa-for-4.4
>
> Hi Robert,
>
> I'm glad to see all this activity on PXA! You're reaching the amount of new
> stuff that it's time to start splitting up in topics. I'll merge this branch
> for this release, but I'm also going to go through below and show you how this
> can/should be split up in the future.
Ok, great !

> First, take a look at our tree and how it's organized. Look at my presentation
> from ELC 2014, or Arnd's from this year, to get an idea of the philosophy we
> use and roughly how we categorize patches.
Ok, just did.
I must admit I've been a bit lazy in this cycle, as I already have my tree split
into cleanup/fix/for-next/dt ...

For cleanup, I understand it all.
For the single fix, I wasn't aware I could make pull request before a merge
window for fixes, I though I could only issue them for post -rc1 series.

>> Petr Cvek (22):
> Most of these are fixes/cleanups. With a burst of patches like this it can
> sometimes be hard to rip them apart and put some in one bucked and others in
> another. Feel free to keep them in a separate topic in that case
> (magician-cleanup or similar)
All right, understood, that translates into a separate pull request.

> Board code, of which we tend to have almost none these days. :-)
I know, I'm working on the ablation, it's just the patient is long to cure :)

>> Thierry Reding (17):
> This could also be a topic on its own. We'd merge it into the cleanup branch at
> our end, but you can provide it as a separate branch if you want.
Okay, understood.

> Don't hesitate to ask if you have questions on how to handle this down the
> road.
Okay, thanks.
I'll try to split better next time. If I see I have another heavy pull-request
(at least heavy in a dying architecture context), I'll try to provide the pull
requests earlier, at -rc4, to let you time to correct me if I messed it up.

Cheers.

-- 
Robert
