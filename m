From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 05 May 2014 01:12:04 +0200
Subject: [PATCH v2 2/5] ARM: Kirkwood: Add DT descriptions for net2big
 and net5big.
In-Reply-To: <20140504225643.GC25314@lunn.ch>
References: <1399142114-24257-1-git-send-email-andrew@lunn.ch>
 <1399142114-24257-3-git-send-email-andrew@lunn.ch>
 <5366AF61.2090806@gmail.com> <20140504225643.GC25314@lunn.ch>
Message-ID: <5366C944.1070709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2014 12:56 AM, Andrew Lunn wrote:
>>> +	gpio_keys {
>>
>> nit: s/gpio_keys/gpio-keys/
>>
> 
> I think this one is debatable. The documentation is called
> gpio_keys.txt, and the example uses gpio_keys. I don't mind chaging it
> in this file, but maybe you can submit a patch changing the example in
> the documentation?

Yes, it definitely is. Both label and node name are allowed to
contain _ and -. Maybe, we should see it is more like a common practice.
Anyway, all comments are nits for a reason :)

I can prepare a patch someday, if I don't forget about it.

Sebastian

>>> +	gpio_poweroff {
>>
>> nit: s/gpio_poweroff/gpio-poweroff/
> 
> ACK.
>  
>> If there is nothing more severe with this, I am sure Jason can
>> just squash in the nits.
> 
> This still needs to be tested on hardware, so there is a good chance
> of a respin.
