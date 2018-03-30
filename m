From: tsoni@codeaurora.org (Trilok Soni)
Date: Thu, 29 Mar 2018 17:31:47 -0700
Subject: [PATCH v3 2/2] drivers: soc: Add LLCC driver
In-Reply-To: <ff949d44-1b2a-15d4-511d-8686a973b081@linaro.org>
References: <1522176722-12691-1-git-send-email-rishabhb@codeaurora.org>
 <1522176722-12691-3-git-send-email-rishabhb@codeaurora.org>
 <ff949d44-1b2a-15d4-511d-8686a973b081@linaro.org>
Message-ID: <9d6dad94-3e17-2ca6-2921-3f461e8315ca@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stanimir,

+/* Get the slice entry by index */
>> +static struct llcc_slice_desc *llcc_slice_get_entry(struct device *dev, int n)
> drop this *slice* word from function names

Please note that we are activating/de-activating? a "slice" of the LLCC 
and not a whole LLCC. "slice" makes perfect sense here since the 
granularity is at the "slice" level and not the complete LLCC.

--Trilok Soni
