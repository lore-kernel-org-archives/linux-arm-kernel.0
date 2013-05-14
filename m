From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 14 May 2013 10:23:20 +0200
Subject: [PATCH 05/14] ARM: shmobile: Remove init_irq declaration in
 machine description
In-Reply-To: <20130514003504.GE12228@verge.net.au>
References: <1368438253-28218-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368438253-28218-6-git-send-email-maxime.ripard@free-electrons.com>
 <20130514003504.GE12228@verge.net.au>
Message-ID: <5191F478.4040800@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Le 14/05/2013 02:35, Simon Horman a ?crit :
> On Mon, May 13, 2013 at 11:44:04AM +0200, Maxime Ripard wrote:
>> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
>> specified") removed the need to explictly setup the init_irq field in
>> the machine description when using only irqchip_init. Remove that
>> declaration for shmobile as well.
> 
> Hi Maxime,
> 
> If possible, I would prefer separate patches for each board and SoC.

Ok, I'll split this and send it in the v2.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
