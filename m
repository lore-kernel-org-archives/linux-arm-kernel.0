From: davidb@codeaurora.org (David Brown)
Date: Tue, 30 Jul 2013 10:17:52 -0700
Subject: [PATCH] mmc: sdhci-msm: Add support for MSM chipsets
In-Reply-To: <86y58orogf.fsf@void.printf.net>
References: <1375201355-26906-1-git-send-email-gdjakov@mm-sol.com>
 <86y58orogf.fsf@void.printf.net>
Message-ID: <20130730171752.GA30897@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 05:40:16PM +0100, Chris Ball wrote:

>On Tue, Jul 30 2013, Georgi Djakov wrote:
>> This platform driver adds the support of Secure Digital Host
>> Controller Interface compliant controller in MSM chipsets.
>>
>> CC: Asutosh Das <asutoshd@codeaurora.org>
>> CC: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>> CC: Sahitya Tummala <stummala@codeaurora.org>
>> CC: Subhash Jadavani <subhashj@codeaurora.org>
>> Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
>> ---
>> This is an initial version of the Qualcomm MSM SDHCI driver.
>> It is based on the SDHCI code from coreaurora.org with minor
>> modifications. The MMC standard DT bindings are used where
>> possible. The patch applies to v3.11-rc3.
>
>Is the arch code that will use this driver already in mainline,
>or on its way in?

It is on it's way.  Once all of the necessary Acks are in place, I'll
be pulling it in.

David

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
