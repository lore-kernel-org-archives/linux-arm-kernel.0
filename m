From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 31 May 2018 11:48:21 +0100
Subject: [PATCH v2 8/9] PM / Domains: Add support for multi PM domains per
 device to genpd
In-Reply-To: <CAPDyKFrtSGF79pFf-sx41ru_EVLk3BMg_f_5rK64k==dW=OXPA@mail.gmail.com>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-9-ulf.hansson@linaro.org>
 <a53f0970-22c4-444f-10e6-c115a21d05ea@nvidia.com>
 <CAPDyKFrV5fosZ1QZ4un+okzpeQDM3QSCBWJB1YZH4WNxKf_FVQ@mail.gmail.com>
 <e313f870-ef27-7721-9395-31671f00ef4a@nvidia.com>
 <CAPDyKFrtSGF79pFf-sx41ru_EVLk3BMg_f_5rK64k==dW=OXPA@mail.gmail.com>
Message-ID: <6dce0c20-f17f-b1be-6654-4bd7ff6f9b62@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 31/05/18 11:44, Ulf Hansson wrote:
> On 31 May 2018 at 10:03, Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>> On 31/05/18 07:17, Ulf Hansson wrote:
>>> [...]
>>>
>>>>> +/**
>>>>> + * genpd_dev_pm_attach_by_id() - Attach a device to one of its PM domain.
>>>>> + * @dev: Device to attach.
>>>>
>>>> Can you update the description of the above as well?
>>>
>>> Yes, like below?
>>>
>>> genpd_dev_pm_attach_by_id() - Associate a device with one of its PM domains.
>>> @dev: The device used to lookup the PM domain.
>>
>> Yes perfect.
> 
> I assume I can consider this as an ack and tested by tag, both for
> patch 8 and 9?

Yes you can.

Cheers
Jon

-- 
nvpublic
