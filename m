From: mylene.josserand@free-electrons.com (Mylene JOSSERAND)
Date: Fri, 29 Dec 2017 12:04:24 +0100
Subject: [PATCH 0/4] Sunxi: Add SMP support on A83T
In-Reply-To: <20171228203125.GB18393@Red>
References: <20171211075001.6100-1-mylene.josserand@free-electrons.com>
 <20171211193534.GA3967@Red>
 <20171212082425.iv37nrpotbb33vh6@flea.lan>
 <20171215061046.GA9845@Red>
 <20171227160729.4509bec5@dell-desktop.home>
 <20171228203125.GB18393@Red>
Message-ID: <20171229120424.01adcc37@dell-desktop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Corentin,

Le Thu, 28 Dec 2017 21:31:25 +0100,
Corentin Labbe <clabbe.montjoie@gmail.com> a ?crit :

[...]

> Hello
> 
> With the .config that you give me in private, everything seems to work.
> But with mine, the stacktrace still happen.
> After some research, this is due to the following code:
> cpumask_set_cpu(get_cpu(), &cci_pmu->cpus);
> which disable preemption (via get_cpu())
> 
> So it is unrelated with your patch, I will send a bug report tomorow.

Okay, great to know that it is not related to my patches.

> 
> Furthermore, you can add:
> Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Thanks, I have just sent a V2. I did not add your tested-by because
I have done some modifications. Could you test this new series and give
me your tested-by again? It would be great!

Thank you in advance,

Best regards,

Myl?ne

-- 
Myl?ne Josserand, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
