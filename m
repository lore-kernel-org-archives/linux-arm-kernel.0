From: jcm@redhat.com (Jon Masters)
Date: Tue, 22 Dec 2015 11:36:38 -0500
Subject: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1EC17CAC@lhreml503-mbb>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <1450278993-12664-23-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EC14C0F@lhreml503-mbb>
 <201512211510.32029.arnd@arndb.de>
 <335CDE2E-B588-43A8-8665-6023AFD0EA04@redhat.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EC17CAC@lhreml503-mbb>
Message-ID: <56797C16.2020802@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2015 04:29 AM, Gabriele Paoloni wrote:
> Hi Jon, thanks for replying
> 
>> -----Original Message-----
>> From: Jon Masters [mailto:jcm at redhat.com]
>> Sent: 21 December 2015 23:11
>> To: Arnd Bergmann
>> Cc: Gabriele Paoloni; Tomasz Nowicki; bhelgaas at google.com;
>> will.deacon at arm.com; catalin.marinas at arm.com; rjw at rjwysocki.net;
>> hanjun.guo at linaro.org; Lorenzo.Pieralisi at arm.com; okaya at codeaurora.org;
>> jiang.liu at linux.intel.com; Stefano.Stabellini at eu.citrix.com;
>> robert.richter at caviumnetworks.com; mw at semihalf.com; Liviu.Dudau at arm.com;
>> ddaney at caviumnetworks.com; tglx at linutronix.de; Wangyijing;
>> Suravee.Suthikulpanit at amd.com; msalter at redhat.com; linux-
>> pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
>> acpi at vger.kernel.org; linux-kernel at vger.kernel.org; linaro-
>> acpi at lists.linaro.org; jchandra at broadcom.com
>> Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space
>> accessors against platfrom specific quirks.
>>
>> Sorry for top-posting. A quick note that SMBIOS3 is required by SBBR so
>> it can be presumed that compliant platforms will provide quirks via DMI.
> 
> Ok so you completely clarified my question 1). Many Thanks for this

No problem. One of the (many) reasons I pushed for requiring SMBIOS/DMI
in SBBR (I was lead author of one of the early drafts of that document)
was to make the experience ultimately equivalent across architectures.
We already know how to do quirks and handle platform deviations, and the
major Operating System vendors did not want to reinvent the wheel.

Jon.
