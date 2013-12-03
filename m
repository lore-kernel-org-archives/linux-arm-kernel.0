From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Tue, 3 Dec 2013 16:41:11 +0000
Subject: [RFC part1 PATCH 1/7] ACPI: Make ACPI core running without PCI
 on ARM64
In-Reply-To: <1386088611-2801-2-git-send-email-hanjun.guo@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <1386088611-2801-2-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20131203164111.GA13447@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Given the number of #ifdefs you're adding, wouldn't it make more sense 
to just add stub functions to include/linux/pci.h?

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
