From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 06 Oct 2014 10:36:03 +0200
Subject: [PATCH 0/8] Armada XP pinctrl consolidation and ix4-300d fixes
In-Reply-To: <54324922.906@gmail.com>
References: <1411157684-6991-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <-7443282711873112734@unknownmsgid>
 <20141003141102.GJ3895@titan.lakedaemon.net> <542EBB93.108@gmail.com>
 <A9781A2E-F3CA-4E8A-833C-D167B456D9F7@perenite.com>
 <542EC3A3.1060605@gmail.com>
 <1ACB5318-863E-40D8-8B27-41F1C0D0A4B8@perenite.com> <54324922.906@gmail.com>
Message-ID: <54325473.5070307@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,


> [...]
>> NR_IRQS:16 nr_irqs:16 16
>> L2C: device tree omits to specify unified cache
> 
> Jason, Thomas, Gregory,
> 
> we should add a "cache-unified" to the l2cc nodes for all SoCs.

Right,
I take care of it.


Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
