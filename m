From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 14 Dec 2017 08:08:08 -0600
Subject: [PATCH v2 1/2] acpi, spcr: Make SPCR avialable to other
 architectures
In-Reply-To: <20171214103027.GB697@e107981-ln.cambridge.arm.com>
References: <20171211155059.17062-1-prarit@redhat.com>
 <20171211155059.17062-2-prarit@redhat.com> <20171213124533.GA32362@red-moon>
 <d967861e-9f83-689c-2b14-58d7450c848b@codeaurora.org>
 <20171214103027.GB697@e107981-ln.cambridge.arm.com>
Message-ID: <6541a055-bfd4-daa7-5b91-38384bd65c3f@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/17 4:30 AM, Lorenzo Pieralisi wrote:
>> I didn't want to put any ACPI code in amba-pl011.c, so putting it in spcr.c
>> made the most sense.  I agree the global variable is ugly.  If you have a
>> better idea, I'm all ears.

> I told you my idea. It could have been made easier by reusing the
> ACPI_DECLARE_PROBE_ENTRY() mechanism.

Sorry, I don't mean to be difficult, but when did you tell *me* this 
idea of yours?  I don't see any email from you to me that mentions 
ACPI_DECLARE_PROBE_ENTRY().  I've never even heard of that macro before. 
  Please note that I'm not the original author of this code.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
