From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 30 Jan 2015 08:48:21 -0600
Subject: [Linaro-acpi] [PATCH v7 04/17] ARM64 / ACPI: Introduce
 early_param for "acpi" and pass acpi=force to enable ACPI
In-Reply-To: <20150130111311.GA27542@e104818-lin.cambridge.arm.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
 <CAOZdJXU2bFR1T4ZnGavvnrUXAp5e=vNt9g6WKX46H8qs1wz-TQ@mail.gmail.com>
 <CAOZdJXXe+29rux1L3QYBX0yHLy3kdi+ZJrXVd=XfgYN=R6DtKA@mail.gmail.com>
 <20150128181453.GG31752@e104818-lin.cambridge.arm.com>
 <54C92804.5090806@codeaurora.org>
 <20150129151956.GF8951@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_=si=L5+vvg+8hRgwmTahqdePw5bZxUMFSZ8obk-VXFQ@mail.gmail.com>
 <20150130111311.GA27542@e104818-lin.cambridge.arm.com>
Message-ID: <54CB99B5.7070505@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> Anyway, rather than a "I-created-an-empty-dtb" property, I would
> actually say something like "dtb-contains-no-hardware-description".

Why do we need a property for this?  Wouldn't the absence of a hardware 
description be the best way to see if the dtb contains no hardware 
description?  It's like putting a sign on an empty bookshelf that says, 
"there are no books here."

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
