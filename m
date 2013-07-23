From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 23 Jul 2013 09:31:35 +0100
Subject: alignment handler instruction endian-ness (Ben Dooks)
In-Reply-To: <CALicx6tS2B_itZHdFh2YrQ2VZOoacx-MuO5vkNfqypH9v5rEiQ@mail.gmail.com>
References: <CALicx6tS2B_itZHdFh2YrQ2VZOoacx-MuO5vkNfqypH9v5rEiQ@mail.gmail.com>
Message-ID: <51EE3F67.4050709@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/07/13 12:38, Vijay Kilari wrote:
> On Fri, Jul 19, 2013 at 5:06 PM, Vijay Kilari<vijay.kilari@gmail.com>  wrote:
>>> Message: 4
>>> Date: Fri, 19 Jul 2013 11:58:45 +0100
>>> From: Ben Dooks<ben.dooks@codethink.co.uk>
>>> To: "linux-arm-kernel at lists.infradead.org"
>>>          <linux-arm-kernel@lists.infradead.org>
>>> Subject: alignment handler instruction endian-ness
>>> Message-ID:<51E91BE5.8070809@codethink.co.uk>
>>> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>>>


[snip]

>>>
>>
>   I think some changes are required in arch/arm/kernel/traps.c
>   for handling undefined instruction as well

I've added those now thanks.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
