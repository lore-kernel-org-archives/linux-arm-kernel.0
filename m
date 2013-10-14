From: philippe.retornaz@epfl.ch (=?ISO-8859-1?Q?Philippe_R=E9tornaz?=)
Date: Mon, 14 Oct 2013 10:47:51 +0200
Subject: [PATCH 1/1] dma: imx-sdma: setup dma mask
In-Reply-To: <20131013234812.GI25034@n2100.arm.linux.org.uk>
References: <1380623464-24652-1-git-send-email-philippe.retornaz@epfl.ch>
 <1380623464-24652-2-git-send-email-philippe.retornaz@epfl.ch>
 <20131013161801.GP2954@intel.com>
 <20131013234812.GI25034@n2100.arm.linux.org.uk>
Message-ID: <525BAFB7.8030402@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 14/10/2013 01:48, Russell King - ARM Linux a ?crit :
> On Sun, Oct 13, 2013 at 09:48:01PM +0530, Vinod Koul wrote:
>> On Tue, Oct 01, 2013 at 12:31:04PM +0200, Philippe R?tornaz wrote:
>>> The dma mask is not configured in the current code.
>>> This was triggered by soc-dmaengine-pcm which allocate the dma
>>> buffers with the imx-sdma as device.
>>> This commit fix audio on imx31.
>>>
>>> Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
>> This needs to go thru Russell's tree, that has the below API
>>
>> Acked-by Vinod Koul <vinod.koul@intel.com>
>
> Indeed.

It's in the patch system with id 7857/1
I hope I got it right.... First time I'm using your patch system.

Thanks,

Philippe
