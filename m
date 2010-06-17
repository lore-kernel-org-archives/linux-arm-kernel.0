From: jason77.wang@gmail.com (jason)
Date: Thu, 17 Jun 2010 21:34:09 +0800
Subject: [PATCH 0/4]Refine iomux files for i.MX51
In-Reply-To: <20100616064723.GH20799@pengutronix.de>
References: <1276352559-8105-1-git-send-email-jason77.wang@gmail.com>
	<20100616064723.GH20799@pengutronix.de>
Message-ID: <4C1A2451.1070101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer wrote:
> On Sat, Jun 12, 2010 at 10:22:35PM +0800, Jason Wang wrote:
>   
>> Through the discussion, I divide my patches to 3 parts.
>> part1: mx51 iomux related part, the first patch in this part is from
>>        Amit, other patches are based off this patch and they are some
>>        fix or adding definitions for imx51_3ds board.
>>     
>
> This is ok now. Can you please rebase onto
> git://git.pengutronix.de/git/imx/linux-2.6.git imx-for-2.6.36
>
> The first patch conflicts with another of your patches:
>
> e5ceef78 mx5: Add i2c to Freescale MX51 Babbage HW
>
>
>   
OK, i will use Amit's new patch and test it based on your repository.

Thanks,
Jason.
