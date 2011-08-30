From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 30 Aug 2011 17:58:15 +0530
Subject: [PATCH 0/6] Add device tree support for PL330 dma controller
	driver
In-Reply-To: <1314638947.1606.157.camel@vkoul-udesk3>
References: <1314348014-2481-1-git-send-email-thomas.abraham@linaro.org>
	<1314638947.1606.157.camel@vkoul-udesk3>
Message-ID: <CAJuYYwQCdWjEzAeO-Gm2GTKO3_ocSOx8sZeBQP-7Y=GbHf=5vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On 29 August 2011 22:59, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> On Fri, 2011-08-26 at 14:10 +0530, Thomas Abraham wrote:
>> This patchset adds device tree support for PL330 driver and uses it
>> to add device tree support for Samsung platforms, specifically Exynos4.
> The DMA patches looks good to me. Do you want this to go thru slave-dma
> tree or somewhere else.
> I will need acks on 3, 5 and 6th patch to carry them.

There are couple of changes required in patch 4/6 of this series. I
will do that and resubmit.

Since these patches are based on Boojin's pl330 driver update patches,
it would be easier to take the same route which Boojin's patches will
take. I will try to get acks' for the patches that you have listed.

Thanks for your help.

Regards,
Thomas.

>
> --
> ~Vinod
>
>
