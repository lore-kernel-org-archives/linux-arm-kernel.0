From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 20 Jun 2016 12:31:43 -0500
Subject: [PATCH V7 0/8] Introduce ACPI world to ITS irqchip
In-Reply-To: <1466420541-20101-1-git-send-email-tn@semihalf.com>
References: <1466420541-20101-1-git-send-email-tn@semihalf.com>
Message-ID: <5768287F.4040503@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 06/20/2016 06:02 AM, Tomasz Nowicki wrote:
> The series builds the PCI/MSI domain stack based on initial IORT driver
> which is added in first place. As a reference please see IORT spec:
> http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Rema
> pping_Table.pdf
>
> Tested on Cavium ThunderX server. The patches can be found here:
> https://github.com/semihalf-nowicki-tomasz/linux.git (its-acpi-v7)
>
>

I have tested this patchset on Qualcomm Technologies server platform 
QDF2XXX.

-- 
Shanker Donthineni
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
