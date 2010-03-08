From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 08 Mar 2010 16:05:28 +0800
Subject: About the phylib supporting of fec.c
In-Reply-To: <20100308075234.GI19843@pengutronix.de>
References: <4B9491B8.2040403@canonical.com>
	<20100308075234.GI19843@pengutronix.de>
Message-ID: <4B94AFC8.4040903@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2010 03:52 PM, Sascha Hauer wrote:
> Hi,
>
> On Mon, Mar 08, 2010 at 01:57:12PM +0800, Bryan Wu wrote:
>> Fred and Sascha,
>>
>> I saw the patch to add phylib supporting of fec.c. And I am working on
>> Ubuntu on Freescale iMX51 kernel. We met a bug about missing link status
>> detection of the fec.c driver:
>> https://bugs.launchpad.net/ubuntu/+source/linux-fsl-imx51/+bug/438687
>>
>> I am going to make phylib work on imx51. Do you guys have any plan to
>> update the patch or will it be applied to upstream?
>
> I would really appreciate seeing an updated version of this patch
> upstream. As far as I know nobody is working on this task atm so feel
> free to do it.
>
> Sascha
>
>

OK, no problem. I will work on this and try to provide an updated version of this.

Thanks
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer    +86.138-1617-6545 Mobile
Ubuntu Kernel Team | Hardware Enablement Team
Canonical Ltd.      www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
