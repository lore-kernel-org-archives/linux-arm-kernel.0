From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 10 Jan 2013 17:53:00 +0530
Subject: [PATCH V3 0/3] ARM: davinci: da850: add pinctrl support
In-Reply-To: <1357813838-26511-1-git-send-email-anilkumar.v@ti.com>
References: <1357813838-26511-1-git-send-email-anilkumar.v@ti.com>
Message-ID: <50EEB2A4.3020103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/10/2013 4:00 PM, Kumar, Anil wrote:
> This set of patches adds:
> 
> * Add pinctrl-single for handling Padconf registers.
> * Add NAND node to export NAND functionality on da850 EVM.
> * Add NAND pinctrl node to do pin mux according to pinctrl-single driver.

Please do not spin versions so fast. Give some reasonable time for
discussion to close before you send a new version. Dont want to see a
flood of versions. It creates confusion.

Thanks,
Sekhar

PS: New address of Kevin Hilman per MAINTAINERS is
khilman at deeprootsystems.com
