From: jun.nie@linaro.org (Jun Nie)
Date: Tue, 22 Mar 2016 09:25:46 +0800
Subject: [PATCH 1/2] serial: amba-pl011: make platform driver generic
In-Reply-To: <56F04FC5.7040907@codeaurora.org>
References: <1457920282-14823-1-git-send-email-jun.nie@linaro.org>
 <56F04FC5.7040907@codeaurora.org>
Message-ID: <CABymUCPMV+L9sRyVPS4rrimr-PcugvGzgVWOCW63psAWY2hSPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-03-22 3:47 GMT+08:00 Timur Tabi <timur@codeaurora.org>:
> Jun Nie wrote:
>
>> -       snprintf(uap->type, sizeof(uap->type), "SBSA");
>> +       snprintf(uap->type, sizeof(uap->type), "PL011 plat");
>
>
> I'm not crazy about this.  I think you need to add a "const char *name"
> field to 'struct vendor_data'.

Will address this suggestion in next version patch. How about "PL011
SBSA" "PL011 ZTE" "PL011 ARM rev1" "PL011 ST rev1"?

Jun
>
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum, a Linux Foundation collaborative project.
