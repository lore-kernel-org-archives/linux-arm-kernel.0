From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Mon, 09 Dec 2013 06:13:43 +0100
Subject: [PATCH] arm: plat-orion: remove deprecated IRQF_DISABLED
In-Reply-To: <20131017125414.GB22434@titan.lakedaemon.net>
References: <1381549760-5432-1-git-send-email-michael.opdenacker@free-electrons.com>
 <20131017125414.GB22434@titan.lakedaemon.net>
Message-ID: <52A55187.3050907@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On 10/17/2013 02:54 PM, Jason Cooper wrote:
> On Sat, Oct 12, 2013 at 05:49:20AM +0200, Michael Opdenacker wrote:
>> This patch proposes to remove the use of the IRQF_DISABLED flag
>>
>> It's a NOOP since 2.6.35 and it will be removed one day.
>>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
>> ---
>>  arch/arm/plat-orion/time.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> Applied to mvebu/soc

Oops, I don't see this patch in mainline yet.

It is still in the tree? Did it just miss the last merge window?

Thanks for your support,

Cheers,

Michael.

-- 
Michael Opdenacker, CEO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
+33 484 258 098
