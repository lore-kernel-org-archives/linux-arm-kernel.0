From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 18 Jun 2013 10:36:11 +0100
Subject: ARM Versatile A15_A7 boot with 3 & 4 Cores
In-Reply-To: <CALicx6s6E6qMmFPmvjikk+UCWaQCHipEdBN-eC33NPO7E9Gx4g@mail.gmail.com>
References: <CALicx6s6E6qMmFPmvjikk+UCWaQCHipEdBN-eC33NPO7E9Gx4g@mail.gmail.com>
Message-ID: <51C02A0B.2000000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/06/13 10:28, Vijay Kilari wrote:

Hi Vijay,

>    Using ARM Versatile board A15 (2 core) & A7 (3 cores) configuration
> with 3.10 SMP kernel with number of cores set to 3 / 4 cores, kernel
> does not boot. Boot fails with Bad page during pgd_alloc()

Can you please try this patch:
http://comments.gmane.org/gmane.linux.ports.arm.kernel/243350

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
