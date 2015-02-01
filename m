From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 01 Feb 2015 20:43:33 +0100
Subject: [PATCH 5/5] ARM: dts: pxa: add pxa-timer to pxa27x
In-Reply-To: <20150201130755.GA25767@leverpostej> (Mark Rutland's message of
 "Sun, 1 Feb 2015 13:07:55 +0000")
References: <1422744510-3179-1-git-send-email-robert.jarzmik@free.fr>
 <1422744510-3179-5-git-send-email-robert.jarzmik@free.fr>
 <20150201130755.GA25767@leverpostej>
Message-ID: <87egq9beoq.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland <mark.rutland@arm.com> writes:

> On Sat, Jan 31, 2015 at 10:48:30PM +0000, Robert Jarzmik wrote:
>> +	clocksources {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges;
>> +
>
> There is absolutely no need for this container node.
>
> Please get rid of it and place the node below directly under the parent
> node.
OK.

Cheers.

--
Robert
