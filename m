From: robherring2@gmail.com (Rob Herring)
Date: Sun, 19 Feb 2012 09:21:19 -0600
Subject: [PATCH 1/4] ARM: sa1100: fix sa1100 after sparse irq conversion
In-Reply-To: <20120218231849.GA1269@n2100.arm.linux.org.uk>
References: <1329449534-23811-1-git-send-email-robherring2@gmail.com>
 <1329449534-23811-2-git-send-email-robherring2@gmail.com>
 <20120218231849.GA1269@n2100.arm.linux.org.uk>
Message-ID: <4F41136F.3060708@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2012 05:18 PM, Russell King - ARM Linux wrote:
> On Thu, Feb 16, 2012 at 09:32:11PM -0600, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> SA1100 was converted to sparse irq in parallel with include of mach/irqs.h
>> being removed from asm/irq.h when sparse irq is enabled, resulting in lots
>> of compile errors.
> 
> Can this be applied before the change to enable sparse IRQ for sa11x0
> platforms without breaking them?

All but the rename of NR_IRQS to SA1100_NR_IRQS should be fine, but I
can change it to leave NR_IRQS.

Rob
