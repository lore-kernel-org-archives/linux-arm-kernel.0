From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Thu, 20 Jun 2013 16:56:43 +0530
Subject: ARM Versatile A15_A7 boot with 3 & 4 Cores
In-Reply-To: <51C02A0B.2000000@arm.com>
References: <CALicx6s6E6qMmFPmvjikk+UCWaQCHipEdBN-eC33NPO7E9Gx4g@mail.gmail.com>
 <51C02A0B.2000000@arm.com>
Message-ID: <CALicx6tx=QbsFzWpamGce50FFBjaB+ncdi0OzGuhFe=6DrZiPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

 I have tested it on versatile TC2. It works

Thanks  & Regards
Vijay

On Tue, Jun 18, 2013 at 3:06 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 18/06/13 10:28, Vijay Kilari wrote:
>
> Hi Vijay,
>
>>    Using ARM Versatile board A15 (2 core) & A7 (3 cores) configuration
>> with 3.10 SMP kernel with number of cores set to 3 / 4 cores, kernel
>> does not boot. Boot fails with Bad page during pgd_alloc()
>
> Can you please try this patch:
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/243350
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
>
