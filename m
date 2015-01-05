From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 5 Jan 2015 12:16:32 +0100
Subject: [PATCH 1/4] ARM: at91: remove at91sam9263 legacy board support
In-Reply-To: <20141222094512.GA4194@piout.net>
References: <cover.1416392687.git.nicolas.ferre@atmel.com>
 <cf26d39a4a251662dbc363092b319b788d223a7b.1416392687.git.nicolas.ferre@atmel.com>
 <1417434775.30245.29.camel@x220> <547C92A1.8000902@atmel.com>
 <1419240528.30945.12.camel@x220> <20141222094512.GA4194@piout.net>
Message-ID: <54AA7290.7000502@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 22/12/2014 10:45, Alexandre Belloni a ?crit :
> Hi Paul,
> 
> On 22/12/2014 at 10:28:48 +0100, Paul Bolle wrote :
>>> So, I suggest to get rid of them during 3.19-rc phase.
>>
>> There's still an entry for RTC_DRV_AT91SAM9_RTT in next-20141221 (and
>> v3.19-rc1). So this I send this message as a reminder that this cleanup
>> is still needed.
>>
> 
> Thanks for the reminder, the pull request was actually waiting for
> 3.19-rc1 to get released before being sent. This should be solved in the
> next rc.

Yes, a new version of this pull-request has just been sent: ([GIT PULL]
at91: fixes for 3.19 #1 (bis)).

Thanks a lot for the reminder Paul. Bye,
-- 
Nicolas Ferre
