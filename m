From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 31 May 2018 08:17:18 +0200
Subject: [PATCH v2 8/9] PM / Domains: Add support for multi PM domains per
 device to genpd
In-Reply-To: <a53f0970-22c4-444f-10e6-c115a21d05ea@nvidia.com>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-9-ulf.hansson@linaro.org>
 <a53f0970-22c4-444f-10e6-c115a21d05ea@nvidia.com>
Message-ID: <CAPDyKFrV5fosZ1QZ4un+okzpeQDM3QSCBWJB1YZH4WNxKf_FVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>> +/**
>> + * genpd_dev_pm_attach_by_id() - Attach a device to one of its PM domain.
>> + * @dev: Device to attach.
>
> Can you update the description of the above as well?

Yes, like below?

genpd_dev_pm_attach_by_id() - Associate a device with one of its PM domains.
@dev: The device used to lookup the PM domain.

Kind regards
Uffe
