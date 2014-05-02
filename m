From: carlo@caione.org (Carlo Caione)
Date: Fri, 2 May 2014 10:27:38 +0200
Subject: [linux-sunxi] Re: [PATCH v5 1/8] mfd: AXP20x: Add mfd driver for
 AXP20x PMIC
In-Reply-To: <20140502081501.GB5206@lee--X1>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
 <1398947374-3115-2-git-send-email-carlo@caione.org>
 <20140502081501.GB5206@lee--X1>
Message-ID: <CAOQ7t2ZNRxuRhQbr-PMUKFSiwXrypBEA1_LmT9fzw6=-+k6awQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 2, 2014 at 10:15 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> This patch introduces the preliminary support for PMICs X-Powers AXP202
>> and AXP209. The AXP209 and AXP202 are the PMUs (Power Management Unit)
>> used by A10, A13 and A20 SoCs and developed by X-Powers, a sister company
>> of Allwinner.
>>
>> The core enables support for two subsystems:
>> - PEK (Power Enable Key)
>> - Regulators
>>
>> Signed-off-by: Carlo Caione <carlo@caione.org>
>> Acked-by: Lee Jones <lee.jones@linaro.org>
>> ---
>
> I guess I can just apply this and expect not to see any adverse
> symptoms?

It has been tested with a sun7i/cubieboard2 with to adverse symptoms.
It's not core stuff so I guess you could apply it.

Thank you,

-- 
Carlo Caione
