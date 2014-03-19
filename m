From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 19 Mar 2014 22:33:11 +0100
Subject: [PATCH 26/62] ARM: mvebu: don't select CONFIG_NEON
In-Reply-To: <20140319193740.GT15608@titan.lakedaemon.net>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-27-git-send-email-arnd@arndb.de>
 <20140319193740.GT15608@titan.lakedaemon.net>
Message-ID: <532A0D17.9060105@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/03/2014 20:37, Jason Cooper wrote:
> On Wed, Mar 19, 2014 at 08:29:23PM +0100, Arnd Bergmann wrote:
>> CONFIG_NEON is meant to be user-selectable. Turning it on
>> unconditionally means we can't build a smaller kernel when
>> we don't need it, and causes build errors if CONFIG_VFP
>> is not also enabled.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Gregory Clement <gregory.clement@free-electrons.com>
>> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> ---
>>  arch/arm/mach-mvebu/Kconfig | 2 --
>>  1 file changed, 2 deletions(-)
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>


Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


> 
> Gregory, Thomas, Ezequiel,
> 
> Care to spin a patch adding NEON to mvebu_v7_defconfig?  (If you want
> it)

I will send a patch in a couple of minute. I'd like that it was applied
on the same release that this patch if possible.


Thanks,

Gregory


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
