From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 Dec 2014 17:09:16 +0100
Subject: [PATCH 00/27] ARM: mvebu: armada-*: Relicense the device tree
 under GPLv2+/X11
In-Reply-To: <20141219160230.GZ967@titan.lakedaemon.net>
References: <1418657915-22775-1-git-send-email-gregory.clement@free-electrons.com>
 <54930BBC.4060602@free-electrons.com>
 <20141218191528.GY967@titan.lakedaemon.net>
 <549437DD.7040602@free-electrons.com>
 <20141219160230.GZ967@titan.lakedaemon.net>
Message-ID: <54944DAC.1000709@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/12/2014 17:02, Jason Cooper wrote:
> On Fri, Dec 19, 2014 at 03:36:13PM +0100, Gregory CLEMENT wrote:
>> On 18/12/2014 20:15, Jason Cooper wrote:
>>> On Thu, Dec 18, 2014 at 06:15:40PM +0100, Gregory CLEMENT wrote:
>>> ...
>>>> Jason at the end it seems you didn't ack or nack the patches were you
>>>> were CC. You expressed some concerns about the GPLv2+ move but I don't know
>>>> if it is something that prevents you to give your acked-by.
>>>
>>> Oops.  :)  I figured my S-o-B when applying would be sufficient.  That
>>> decision was before we decided on Andrew applying patches this time
>>> around...
>>>
>>> For all my dts{i} contributions:
>>>
>>> Acked-by: Jason Cooper <jason@lakedaemon.net>
>>
>> Thanks :)
>>
>>>
>>> Due to all the merge commits over time and whatnot, it's probably best
>>> to put my Ack on all the patches in this series...
>>
>> OK no problem. By the way, I take care of collecting all the acked-by and
>> once it will be done I will either sent the updated patch set with all the
>> acked-by or maybe just I will create a branch to pull if it is easier to handle.
> 
> Ok, that'll be up to Andrew.
> 
> Once we have the last few stragglers, and assuming there are no more
> NAKs, here's what I'd like to do:
> 
> Regrettably, we'll have to revert Simon's dts contributions.  I say

You missed the email he sent yesterday, finally Simon changed his mind
and gave his acked-by.


> 'regret' in that I regret having to potentially discourage a valuable
> contributor.  I *don't* regret him sticking to his guns.  :)
> 
> As for what to do after that, I think we (the core mvebu folks) should
> *not* rewrite the Lacie dts files.  That just seems hinky to me.
> 
> If there's community interest, someone will crop up who copies one of
> the dual licensed dts files and modifies it to boot his/her Lacie board.
> When they submit a patch, we'll DCO/SoB double check them and apply the
> patch(es).
> 
> 
> thx,
> 
> Jason.
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
