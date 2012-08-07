From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 7 Aug 2012 15:05:45 +0200
Subject: [GIT PULL] at91: platform data for atmel-mci (for 3.5)
In-Reply-To: <50110163.70002@atmel.com>
References: <4FBE4FE7.3010005@atmel.com> <4FC722B7.10409@atmel.com>
 <201207252006.44523.arnd@arndb.de> <50110163.70002@atmel.com>
Message-ID: <502112A9.4060703@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2012 10:35 AM, ludovic.desroches :
> Hi Arnd,
> 
> Le 07/25/2012 10:06 PM, Arnd Bergmann a ?crit :
>> On Thursday 31 May 2012, Nicolas Ferre wrote:
>>>
>>> On 05/24/2012 05:12 PM, Nicolas Ferre :
>>>> Hi Arnd, hi Olof,
>>>
>>> Ping?
>>>
>>> (or maybe you will have a look at this after the merge window...)
>>>
>>
>> I've just gone through all old pull requests that I had somewhere in
>> my inbox and this turned out to be one that we never pulled.
>>
>> It looks like it still applies and we should send it to Linus as as
>> late branch this time, given that we screwed up and it was there
>> all the time.
>>
>> Nicolas, can you please confirm?
>>
> 
> Nicolas is on vacation, he'll be back on week 32.
> 
> Nicolas and Olof discussed about this addition of ifdefs to manage the
> two drivers. They agreed to remove platform data for the old driver.
> 
> It will be great to go ahead with this patch. I see three solutions:
> - take the patch and we will do a new patch to remove old platform data
> for 3.7 when at91-mci will be totally removed but it seems that Olof
> doesn't like this solution.
> - I can write a new patch to remove old platform data as planned by
> Nicolas. If Jean-Christophe gives his acked-by, you could take it.
> - wait Nicolas' return but it may be too late then we won't have the
> smooth transition we wanted.

I am back in the game ;-)

I am about to rebuild a pull-request with what we discussed with Olof:
complete removal of old driver's platform data.

You still have the possibility to queue it as a late branch for 3.6...
(I keep it based on 3.5-rc, but I can rebase it on 3.6-rc1 to ease one
conflict resolution when merging with current Linus' tree).

Bye,
-- 
Nicolas Ferre
