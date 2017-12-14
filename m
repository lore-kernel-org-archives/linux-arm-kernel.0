From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 14 Dec 2017 15:49:43 +0000
Subject: [PATCH v2 1/2] acpi, spcr: Make SPCR avialable to other
 architectures
In-Reply-To: <6541a055-bfd4-daa7-5b91-38384bd65c3f@codeaurora.org>
References: <20171211155059.17062-1-prarit@redhat.com>
 <20171211155059.17062-2-prarit@redhat.com>
 <20171213124533.GA32362@red-moon>
 <d967861e-9f83-689c-2b14-58d7450c848b@codeaurora.org>
 <20171214103027.GB697@e107981-ln.cambridge.arm.com>
 <6541a055-bfd4-daa7-5b91-38384bd65c3f@codeaurora.org>
Message-ID: <20171214154943.GA29588@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 08:08:08AM -0600, Timur Tabi wrote:
> On 12/14/17 4:30 AM, Lorenzo Pieralisi wrote:
> >>I didn't want to put any ACPI code in amba-pl011.c, so putting it in spcr.c
> >>made the most sense.  I agree the global variable is ugly.  If you have a
> >>better idea, I'm all ears.
> 
> >I told you my idea. It could have been made easier by reusing the
> >ACPI_DECLARE_PROBE_ENTRY() mechanism.
> 
> Sorry, I don't mean to be difficult, but when did you tell *me* this idea of
> yours?  I don't see any email from you to me that mentions

I said that IMO it would have been better if the quirk was managed in
amba-pl011.c - you had your reasons not to do it, end of the story.

> ACPI_DECLARE_PROBE_ENTRY().  I've never even heard of that macro before.
> Please note that I'm not the original author of this code.

It is what it is, let's move on, we will keep this in mind if a similar
quirk is required.

Thanks,
Lorenzo
