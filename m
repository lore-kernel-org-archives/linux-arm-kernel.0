From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 01 Mar 2012 19:50:50 +0100
Subject: Linux 3.3-rc5 and pxa-gpio possible regression
In-Reply-To: <1330565036.86950.YahooMailClassic@web29009.mail.ird.yahoo.com>
 (Paul Parsons's message of "Thu, 1 Mar 2012 01:23:56 +0000 (GMT)")
References: <1330565036.86950.YahooMailClassic@web29009.mail.ird.yahoo.com>
Message-ID: <87sjhstat1.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Parsons <lost.distance@yahoo.com> writes:

>> I've tried the 3.3-rc5 kernel and my boot hangs (PXA270
>> platform).
>
> Same here. Your problem may be the same as this:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/084307.html
>
> Does the patch below fix your problem?
Yes, absolutely, it fixes it.

Thanks for the info.

Cheers.

--
Robert
