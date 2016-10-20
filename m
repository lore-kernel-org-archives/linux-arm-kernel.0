From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 20 Oct 2016 07:06:08 -0700
Subject: [PATCH V6 00/10] dmaengine: qcom_hidma: add MSI interrupt support
In-Reply-To: <20161020094838.GY2467@localhost>
References: <1476899512-20431-1-git-send-email-okaya@codeaurora.org>
 <20161020094838.GY2467@localhost>
Message-ID: <e3cbd6a2-7fac-98ec-74ea-0be88075663c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On 10/20/2016 2:48 AM, Vinod Koul wrote:
>> 6:
>> > * rebase 4.9 kernel
> Why???
> 

This is more for me. There is nothing special about 4.9 that impacts hidma.
It just means that I retested the code against 4.9-rc1 kernel.

> 
> I already told you that I have applied 6 in the last version, please dont
> send me stuff which is already applied :(

I couldn't find your applied branch on git yesterday. That's why, I sent you
the whole thing so that you can pick the last 4 ones. You don't need to reapply
the first 6. Better to have everything than missing code.

slave-dma       git://git.infradead.org/users/vkoul/slave-dma.git (fetch)
slave-dma       git://git.infradead.org/users/vkoul/slave-dma.git (push)

If you prefer a reduced list, please make your current changelist available on
one of the branches on git, I can reapply, test and send only the remaining ones.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
