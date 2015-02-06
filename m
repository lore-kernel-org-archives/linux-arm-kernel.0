From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 06 Feb 2015 23:57:41 +0100
Subject: [PATCH 5/5] ARM: dts: pxa: add pxa-timer to pxa27x
In-Reply-To: <54CE0D7A.3070603@cogentembedded.com> (Sergei Shtylyov's message
 of "Sun, 01 Feb 2015 14:26:50 +0300")
References: <1422744510-3179-1-git-send-email-robert.jarzmik@free.fr>
 <1422744510-3179-5-git-send-email-robert.jarzmik@free.fr>
 <54CE0D7A.3070603@cogentembedded.com>
Message-ID: <87mw4q8x7e.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> writes:

>> +	clocksources {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges;
>> +
>> +		pxa-timer at 40a00000 {
>
>    Just "timer at 40a00000", please.
Hi Sergei,

I forgot that in the v2, sorry. I'll put it in v3.

Cheers.

-- 
Robert
