From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 20 Mar 2014 22:42:52 +0300
Subject: [PATCH 06/62] ARM: davinci: export da8xx_syscfg0_base
In-Reply-To: <532B155F.9020605@cogentembedded.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <4836281.0IgPinItBq@wuerfel> <532A1BDD.904@cogentembedded.com>
 <9096065.aGCg8yZblW@wuerfel> <532B155F.9020605@cogentembedded.com>
Message-ID: <532B44BC.1080807@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2014 07:20 PM, Sergei Shtylyov wrote:

>> The syscon (system controller) framework helps share a set of registers
>> across multiple drivers. If all accesses to the CFGCHIP2 register are
>> in a single PHY driver, we wouldn't need it.

>     Where can I find it in the kernel tree?

    Found it.

WBR, Sergei
