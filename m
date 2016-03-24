From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 24 Mar 2016 09:53:38 +0100
Subject: [PATCH v5 0/2] power: reset: support for Atmel alternative
 Shutdown Controller
In-Reply-To: <20160323211144.GA31473@earth>
References: <1458134390-23847-1-git-send-email-nicolas.ferre@atmel.com>
 <56F27B96.5010406@atmel.com> <20160323211144.GA31473@earth>
Message-ID: <56F3AB12.20701@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 23/03/2016 22:11, Sebastian Reichel a ?crit :
> Hi Nicolas,
> 
> On Wed, Mar 23, 2016 at 12:18:46PM +0100, Nicolas Ferre wrote:
>> Le 16/03/2016 14:19, Nicolas Ferre a ?crit :
>>> This is a series to add driver for a new Atmel Shutdown Controller. This new IP
>>> is extensible and some features will be added later (see the TODO section).
>>> Its extensible nature led to write a new binding so that wake-up sources can be
>>> described easily.
>>
>> I have the feeling that this series is ready. What do you think?
> 
> I have see obvious problems with this series and plan to queue this

I would be reassured if a "not" was actually missing in the sentence
above... ;-)

Bye,

> after the merge window has closed. I give patches one more review
> while applying them, so at that point something might turn up.
> 
>> So, do you want me to collect everybody's tags and send another version
>> or you can do it yourself?
> 
> I can collect the tags myself.
> 
>> BTW, I will certainly send the device tree updates for the sama5d2 SoC,
>> but it will go through the AT91 then arm-soc git trees. No need for
>> further synchronization here.
> 
> I will ignore the *.dts patches.
> 
> -- Sebastian
> 


-- 
Nicolas Ferre
