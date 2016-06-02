From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Thu, 2 Jun 2016 10:06:27 +0000
Subject: [PATCH V8 0/9] Support for ARM64 ACPI based PCI host controller
In-Reply-To: <f606faa9-72f3-3219-02a8-69e948338d2e@redhat.com>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F767865@lhreml507-mbx>
 <f606faa9-72f3-3219-02a8-69e948338d2e@redhat.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F769AAB@lhreml507-mbx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon

> -----Original Message-----
> From: Jon Masters [mailto:jcm at redhat.com]
> Sent: 02 June 2016 08:32
> To: Gabriele Paoloni; Tomasz Nowicki; helgaas at kernel.org;
> arnd at arndb.de; will.deacon at arm.com; catalin.marinas at arm.com;
> rafael at kernel.org; hanjun.guo at linaro.org; Lorenzo.Pieralisi at arm.com;
> okaya at codeaurora.org; jchandra at broadcom.com
> Cc: robert.richter at caviumnetworks.com; mw at semihalf.com;
> Liviu.Dudau at arm.com; ddaney at caviumnetworks.com; Wangyijing;
> Suravee.Suthikulpanit at amd.com; msalter at redhat.com; linux-
> pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> acpi at vger.kernel.org; linux-kernel at vger.kernel.org; linaro-
> acpi at lists.linaro.org; jcm at redhat.com; andrea.gallo at linaro.org;
> dhdang at apm.com; jeremy.linton at arm.com
> Subject: Re: [PATCH V8 0/9] Support for ARM64 ACPI based PCI host
> controller
> 
> On 06/01/2016 03:36 AM, Gabriele Paoloni wrote:
> 
> > If you agree I think Jon can tell who's the best person to
> > push the quirk RFC (as my understanding is that this mechanism
> > is currently used by some platforms deployed on the market...)
> 
> Let me ping Linaro folks to see who has that (quirks) ball. We can
> certainly share the older OEM matching quirks Mark Salter did for
> earlier RHEL(SA) internal versions as a seed for that[0] activity.

Tomasz has posted the RFC so we'll start to look at that

> 
> BUT...I don't think we should block this thread on the quirks. They're
> separate (but important). I see Arnd's reply as well, but nobody else
> has yet chimed in to this thread (and I am about to prod all of the
> vendors to reply to this thread and ACK). Can I ask whether we can't
> just stage v8 as-is for -next at this point? Can Arnd's (or other)
> suggestions be handled as followup patches post-merge please? Bjorn?

I will ask HiSilicon folks to test it so we can add Tested-by on this

Thanks

Gab

> 
> Jon.
> 
> [0] RHEL(SA) has had three different PCIe enabled ACPI stacks
> maintained
> independently so far since we need PCIe to boot most of the hundreds of
> v8 systems we have internal to Red Hat - which all have PCI.
> 
> --
> Computer Architect | Sent from my Fedora powered laptop
