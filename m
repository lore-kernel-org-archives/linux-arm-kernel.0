From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 11 Feb 2013 10:59:53 +0000
Subject: [PATCH 1/2] net: calexdaxgmac: fix printing of hardware version
In-Reply-To: <5118208C.7010109@gmail.com>
References: <1360510721-17860-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360510721-17860-2-git-send-email-ben.dooks@codethink.co.uk>
 <5118208C.7010109@gmail.com>
Message-ID: <5118CF29.3040205@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/13 22:34, Rob Herring wrote:
> On 02/10/2013 09:38 AM, Ben Dooks wrote:
>> The current driver attempts to print netdev_info() before registering the
>> network device and allowing the name to be set. Change this print to be
>> after the network deviec has been registered, and thus has been allocated
>
> You missed the typo pointed out on the first version sent to lakml.

Oops, sorry.

>> a network device name.
>>
>> Fix the following issue:
>>
>> calxedaxgmac fff50000.ethernet (unregistered net_device): h/w version is 0x1012
>>
>> Signed-off-by: Ben Dooks<ben.dooks@codethink.co.uk>
>
> Otherwise,
>
> Acked-by: Rob Herring<rob.herring@calxeda.com>

Thanks.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
