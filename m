From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Sep 2012 11:36:07 -0700
Subject: [PATCH 09/10] ARM: msm: Make proc_comm clock control into a
 platform driver
In-Reply-To: <CADTbHxoNdmAWaZ1dDYz_8zFr6xDxp8NYHPGF_WjYbeTWLmuMQw@mail.gmail.com>
References: <1348194419-11486-1-git-send-email-sboyd@codeaurora.org>
 <1348194419-11486-10-git-send-email-sboyd@codeaurora.org>
 <CADTbHxoNdmAWaZ1dDYz_8zFr6xDxp8NYHPGF_WjYbeTWLmuMQw@mail.gmail.com>
Message-ID: <50634B17.8050204@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/12 11:03, Pankaj Jangra wrote:
>
>> +
>> +static int __devinit msm_clock_pcom_probe(struct platform_device *pdev)
>> +{
>> +       struct pcom_clk_pdata *pdata = pdev->dev.platform_data;
> Should'nt it be const struct?

Sure. Fixed.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
