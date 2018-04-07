From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Sat, 7 Apr 2018 13:43:05 +0300
Subject: [PATCH v3 2/2] drivers: soc: Add LLCC driver
In-Reply-To: <a44193e11069b4107985776fa323782b@codeaurora.org>
References: <1522176722-12691-1-git-send-email-rishabhb@codeaurora.org>
 <1522176722-12691-3-git-send-email-rishabhb@codeaurora.org>
 <ff949d44-1b2a-15d4-511d-8686a973b081@linaro.org>
 <a44193e11069b4107985776fa323782b@codeaurora.org>
Message-ID: <f6671b63-8f61-7a6b-8e4a-93dbe06a2da0@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On  4.04.2018 20:30, rishabhb at codeaurora.org wrote:
> Hi Stanimir,
> We incorporated all your comments except the following:
> 1. Removing the driver that maintains the SCT (system cache table)
> per chipset. As responded earlier the data is expected to change
> from chipset to chipset and would clutter the main driver if we
> choose using compatible string. We think its good to keep the data
> separate from core driver.
> 2. Changing struct llcc_slice_desc to llcc_desc:
> The descriptor is specific to each slice and not the whole llcc.
> All the properties such as id and size are specific to each slice
> and not whole llcc.
> 
> please let me know if you are ok with the approach. Based on that
> I can send my next revision of changes.

Yes, please go ahead and send the next version.

regards,
Stan
