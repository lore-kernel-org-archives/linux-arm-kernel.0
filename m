From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 29 Jan 2015 12:21:54 -0600
Subject: [Linaro-acpi] [PATCH v7 04/17] ARM64 / ACPI: Introduce early_param
 for "acpi" and pass acpi=force to enable ACPI
In-Reply-To: <CAKv+Gu_=si=L5+vvg+8hRgwmTahqdePw5bZxUMFSZ8obk-VXFQ@mail.gmail.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>	<1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>	<CAOZdJXU2bFR1T4ZnGavvnrUXAp5e=vNt9g6WKX46H8qs1wz-TQ@mail.gmail.com>	<CAOZdJXXe+29rux1L3QYBX0yHLy3kdi+ZJrXVd=XfgYN=R6DtKA@mail.gmail.com>	<20150128181453.GG31752@e104818-lin.cambridge.arm.com>	<54C92804.5090806@codeaurora.org>	<20150129151956.GF8951@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_=si=L5+vvg+8hRgwmTahqdePw5bZxUMFSZ8obk-VXFQ@mail.gmail.com>
Message-ID: <54CA7A42.5080800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2015 12:20 PM, Ard Biesheuvel wrote:
> If we are going with this solution, we should also mandate that an
> ACPI enabled firmware should not supply a non-DT DTB

What is a non-DT DTB?  I thought the "DT" in "DTB" stood for device tree.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
