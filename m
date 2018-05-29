From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 29 May 2018 21:13:54 +0200
Subject: [RESEND PATCH] dmaengine: pxa: add a default requestor policy
In-Reply-To: <20180529072401.GG5666@vkoul-mobl> (Vinod's message of "Tue, 29
 May 2018 12:54:01 +0530")
References: <20180526095418.22960-1-robert.jarzmik@free.fr>
 <20180529072401.GG5666@vkoul-mobl>
Message-ID: <874liqtgul.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod <vkoul@kernel.org> writes:

> On 26-05-18, 11:54, Robert Jarzmik wrote:
>> @@ -762,6 +762,8 @@ static void pxad_free_chan_resources(struct dma_chan *dchan)
>>  	dma_pool_destroy(chan->desc_pool);
>>  	chan->desc_pool = NULL;
>>  
>> +	chan->drcmr = (u32)-1;
>
> why not use U32_MAX for this?
But of course, anything else you see ?

Cheers.

-- 
Robert
