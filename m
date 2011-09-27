From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 27 Sep 2011 09:58:55 +0100
Subject: [PATCH v2 00/16] Switch GIC users (and omap2plus) to
	CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <20110927001514.GB16174@huya.qualcomm.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
	<20110926202007.GB27355@huya.qualcomm.com>
	<20110927001514.GB16174@huya.qualcomm.com>
Message-ID: <4E81904F.1010406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/09/11 01:15, David Brown wrote:
> On Mon, Sep 26, 2011 at 01:20:07PM -0700, David Brown wrote:
>> On Mon, Sep 26, 2011 at 12:02:19PM +0100, Marc Zyngier wrote:
>>
>>> This series has been tested on VE (A9, A5, A15), PB11MP, Panda, IGEPv2
>>> and Harmony. Patches against next-20110926 plus my PPI series.
>>
>> Tested on an msm8660.
>>
>> Tested-by: David Brown <davidb@codeaurora.org>
>> Acked-by: David Brown <davidb@codeaurora.org>
> 
> Tested as well on msm8250.

Awesome. Thanks a lot for testing all of this David.

	M.
-- 
Jazz is not dead. It just smells funny...
