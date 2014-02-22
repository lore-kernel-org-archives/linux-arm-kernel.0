From: dashie@sigpipe.me (Dashie)
Date: Sat, 22 Feb 2014 20:44:07 +0100
Subject: Stuck getting DTS working for a new kirkwood board
In-Reply-To: <20140222193031.GG6667@lunn.ch>
References: <20140221013407.GX7862@titan.lakedaemon.net>
 <5307029C.20006@sigpipe.me> <20140221151530.GZ7862@titan.lakedaemon.net>
 <5307A727.9080508@sigpipe.me> <20140221200855.GM7862@titan.lakedaemon.net>
 <5307CCCD.5010505@sigpipe.me> <20140221221251.GH11878@lunn.ch>
 <530865C9.6000704@sigpipe.me> <20140222184119.GF6667@lunn.ch>
 <5308F16C.1070207@sigpipe.me> <20140222193031.GG6667@lunn.ch>
Message-ID: <5308FE07.5070809@sigpipe.me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/22/2014 08:30 PM, Andrew Lunn wrote:
>> root at debian:~# i2cdetect 0
>> WARNING! This program can confuse your I2C bus, cause data loss and worse!
>> I will probe file /dev/i2c-0.
>> I will probe address range 0x03-0x77.
>> Continue? [Y/n]
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>> 00:          -- -- -- -- -- -- -- -- -- UU -- -- --
>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 40: -- -- -- -- -- -- -- -- -- UU -- -- -- -- -- --
>> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 60: -- -- -- -- 64 -- -- -- -- -- -- -- -- -- -- --
>> 70: -- -- -- -- -- -- -- --
> The datasheet for M41TC8025 says it uses 0x64.
>
> Could you of read the part wrong from the photo?
>
>       Andrew
The only readings on the chip is :
"M41T80
ST(logo) E9927"

I have a picture here :
http://wiki.sigpipe.me/lib/exe/fetch.php?media=hacking:img_3329.jpg
