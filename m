From: tn@semihalf.com (Tomasz Nowicki)
Date: Thu, 11 Feb 2016 19:46:22 +0100
Subject: [PATCH V4 22/23] arm64, pci, acpi: Assign legacy IRQs once device
 is enable.
In-Reply-To: <20160211115843.GA24136@red-moon>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
 <1454606941-9523-23-git-send-email-tn@semihalf.com>
 <20160211115843.GA24136@red-moon>
Message-ID: <56BCD6FE.4030107@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.02.2016 12:58, Lorenzo Pieralisi wrote:
> As for the MSI check, by reading commit history its need I think
> it harks back to bba6f6fc, which was supposed to be a quick hack and it
> has been in the kernel for 9 years:), is it really needed ?

IMO, yes it is needed. We need to chose MSI vs IRQ, and MSI is 
preferable option.

Tomasz
