From: robherring2@gmail.com (Rob Herring)
Date: Tue, 06 Mar 2012 15:10:43 -0600
Subject: [PATCH v4 3/4] ARM: msm: use runtime ioremap hook
In-Reply-To: <20120306205954.GA21912@codeaurora.org>
References: <alpine.LFD.2.02.1203051545200.31242@xanadu.home>
 <1331006580-3579-1-git-send-email-robherring2@gmail.com>
 <1331006580-3579-3-git-send-email-robherring2@gmail.com>
 <20120306205954.GA21912@codeaurora.org>
Message-ID: <4F567D53.9040204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2012 02:59 PM, David Brown wrote:
> On Mon, Mar 05, 2012 at 10:02:59PM -0600, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Convert msm platforms to use run-time ioremap hook instead of the compile
>> time hook.
>>
>> According to David Brown, only the msm7201 needed the ioremap hook.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> Tested-by: David Brown <davidb@codeaurora.org>
>> Acked-by: David Brown <davidb@codeaurora.org>
>> Cc: Daniel Walker <dwalker@fifo99.com>
>> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> 
> This still is working on 8660.
> 
> BTW, I'm not able to cleanly apply the IMX patches.  What tree are you
> basing that off of?
> 

That would be the restart clean-up branch which I don't need, but the
at91 and omap clean-up branches I'm based on have pulled that branch in.

Rob
