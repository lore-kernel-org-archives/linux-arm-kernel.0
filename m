From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 10 Oct 2014 14:55:28 -0700
Subject: [PATCH v3 0/2] bus: brcmstb_gisb: misc fixes
In-Reply-To: <1956888.MIJ5XMTDdo@wuerfel>
References: <1411408966-15390-1-git-send-email-f.fainelli@gmail.com>
 <5438329D.1040600@gmail.com> <1956888.MIJ5XMTDdo@wuerfel>
Message-ID: <543855D0.9030108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2014 02:10 PM, Arnd Bergmann wrote:
> On Friday 10 October 2014 12:25:17 Florian Fainelli wrote:
>>
>> On 09/22/2014 11:02 AM, Florian Fainelli wrote:
>>> Hi Arnd,
>>>
>>> This patch set contains two small fixes for the Broadcom GISB bus
>>> arbiter code. First patch makes sure we do register a fault code for
>>> ARM platforms, second patch is a fix when the code is used on a PM
>>> capable system.
>>
>> Once the merge window re-opens in about a week from now, how do you want
>> me to submit those patches? Do you want them as part of a brcmstb pull
>> request, or something else?
> 
> At least one of us is confused. The merge window is currently open,
> and I have send all outstanding pull requests for 3.18. If you have
> bug fixes that are required for 3.18, we should merge them now and
> send them as soon as possible.

I'm the one confusing the terms here, I meant to write: "when you start
queuing patches again".

> 
> If this is stuff that can wait for 3.19, please send a pull
> request after the the end of the ELC/LPC conferences next week
> so we can queue it up in next/fixes-non-critical.

That can wait for 3.19, thanks!
--
Florian
