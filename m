From: pekon@ti.com (Gupta, Pekon)
Date: Wed, 2 Jul 2014 05:33:37 +0000
Subject: [PATCH] arm: mach-omap2: gpmc: ignore non-available nodes
In-Reply-To: <20140626163707.GA26836@arch.cereza>
References: <1403794923-19511-1-git-send-email-guido@vanguardiasur.com.ar>
 <20140626163707.GA26836@arch.cereza>
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EAF8D44@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From: Ezequiel Garc?a [mailto:ezequiel at vanguardiasur.com.ar]
>>On 26 Jun 12:02 PM, Guido Mart?nez wrote:
>> Currently, child nodes of the gpmc node are iterated and probed
>> regardless of their 'status' property. This means adding 'status =
>> "disabled";' has no effect.
>>
>> This patch changes the iteration to only probe nodes marked as
>> available.
>>
>> Signed-off-by: Guido Mart?nez <guido@vanguardiasur.com.ar>
>
>Just a nit: the commit title doesn't match the recent commits. If you
>run "git log" on this file, you'll find the pattern should be something
>like:
>
>"ARM: OMAP2+: GPMC should only probe enabled devices"
>
>Other than this, the patch looks correct.
>
Yes, plz keep patch title consistent as in other gpmc.c patches.
And thanks for this fix.

Tested-by: Pekon Gupta <pekon@ti.com>

with regards, pekon
