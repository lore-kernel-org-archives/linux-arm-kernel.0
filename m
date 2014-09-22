From: ahs3@redhat.com (Al Stone)
Date: Mon, 22 Sep 2014 16:40:11 -0600
Subject: [PATCH v4 18/18] Documentation: ACPI for ARM64
In-Reply-To: <20140922194841.GA9868@amd>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-19-git-send-email-hanjun.guo@linaro.org>
 <20140922194841.GA9868@amd>
Message-ID: <5420A54B.8080202@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22/2014 01:48 PM, Pavel Machek wrote:
> On Fri 2014-09-12 22:00:16, Hanjun Guo wrote:
>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>
>> Add documentation for the guidelines of how to use ACPI
>> on ARM64.
> 
>> +No code shall be accepted into the kernel unless it complies with the released
>> +standards from UEFI ASWG. If there are features missing from ACPI to make it
>> +function on a platform, ECRs should be submitted to ASWG and go through the
>> +approval process.
> 
> Surely this should be narrowed down somehow? Or is reading all the
> released standards from ASWG mandatory before patching the kernel now?

Asking someone to read the ACPI standard when implementing ACPI
functionality is no different than doing the same thing for PCI,
SCSI, TCP/IP or any of a bazillion others that are used by the
kernel.  Yes, the wording of this sentence is awkward; that's a
very different problem and easily fixed.

> Spelling out wtf ECR is would be nice, too.

ECR stands for "Engineering Change Request".  It is simply a
recommended document format for requesting changes to be made to
the ACPI specification (and is also used by other UEFI working
groups).  The text can easily be fixed to make that clear.

> And if you expect all kernel contributors to comply with your
> favourite standards, you should put an URL where the standards can be
> downloaded here.
> 

Easily enough corrected; until the patch is updated, one can find
the specs at the oh so very cleverly named URL:

    http://www.uefi.org/specifications


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
