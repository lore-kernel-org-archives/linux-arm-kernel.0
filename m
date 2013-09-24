From: cinifr@gmail.com (cinifr)
Date: Wed, 25 Sep 2013 00:22:44 +0800
Subject: [PATCH V3: Add Smp support for Allwinner A20. 1/3] Add smp
 support for Allwinner A20(sunxi 7i).
In-Reply-To: <20130923181707.GR2779@lukather>
References: <1379852488-32147-1-git-send-email-cinifr@gmail.com>
 <1379852488-32147-2-git-send-email-cinifr@gmail.com>
 <20130923181707.GR2779@lukather>
Message-ID: <CAK3cCBwLrnV7L9WzJ+1P_62PEjEEtgzVjFH8m6SZzWG1O+2vEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> Please use sun7i here as well.
>
Ok, it will be modified by next patch.

>> +early_initcall(sunxi_init_cpuconfig_map);
>
> You still haven't said why you don't want to use smp_init_cpus there.
I find that of_funcation liking of_find_matching_node and of_iomap can
not run well in smp_init_cpus. It cause kernel crash. So I have to use
early_initcall.

Fan
