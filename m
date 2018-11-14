From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 14 Nov 2018 11:34:27 +0100
Subject: PCMCIA / PXA27X / CPUFREQ
In-Reply-To: <CAJD+NwpE+uS99fe2uXM0X6WwRyegTm3wXNHWPM_xM0r3+nrhBw@mail.gmail.com>
 (Greg's message of "Tue, 6 Nov 2018 18:00:49 +1300")
References: <CAJD+NwqUdDRFisnPtj9QCm=F2bHMSMfRkK1UWedJcS6_UmLhYg@mail.gmail.com>
 <87efc0oatr.fsf@belgarion.home>
 <CAJD+NwpE+uS99fe2uXM0X6WwRyegTm3wXNHWPM_xM0r3+nrhBw@mail.gmail.com>
Message-ID: <87pnv8j6bw.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg <greguu@null.net> writes:

> On Mon, 5 Nov 2018 at 09:18, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>>
>> Greg <greguu@null.net> writes:
>>
>> > Hi Robert,
>>
>> Hi Greg,
>>
>> I will make some tests next week to confirm your status, I don't seem to
>> remember any specific issue on PCMCIA lately, but that was before v4.19 so one
>> might have sneaked it.
>>
> It sneaked in a some time ago, I think with 4.8 or so but it took us a
> while to find out what is causing it and report it.
Ok Greg, I made some preliminary tests.

On my side, the PCMCIA insertion is not detected as well. I'm pretty sure though
it was working April 21st, 2018, as I have evidence in my git trees I made the
test.

I will investigate on my side now I know the problem can be reproduced, even if
my case could be some issue on the test platform ...

Cheers.

--
Robert
