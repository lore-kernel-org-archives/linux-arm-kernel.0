From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Thu, 17 May 2012 20:25:21 +0200
Subject: [PATCH 0/4] mmc: atmel-mci: add support for old mci IPs
In-Reply-To: <87obpn3rm0.fsf@laptop.org>
References: <1337174761-23988-1-git-send-email-ludovic.desroches@atmel.com>
 <87obpn3rm0.fsf@laptop.org>
Message-ID: <4FB54291.4080509@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/17/2012 02:43 PM, Chris Ball a ?crit :
> Hi Ludovic,
>
> On Wed, May 16 2012, ludovic.desroches at atmel.com wrote:
>> This set of patches is an extra step to remove at91-mci dirver which is mainly
>> used for old chips having mci IPs whose version is lesser than v2xx (rm9200
>> and 9261).
>> Since it introduces many changes and there was a lack of logs to help people
>> when there is an issue with atmel-mci driver, I added some debug logs.
>>
>> These changes have been tested on at91rm9200, at91sam9261, at91sam9263,
>> at91sam9g10 and at91sam9g45.
>
> Thanks, pushed all four to mmc-next for 3.5.
>
> - Chris.

Thanks Chris
