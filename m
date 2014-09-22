From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Tue, 23 Sep 2014 00:07:58 +0100
Subject: [PATCH v4 18/18] Documentation: ACPI for ARM64
In-Reply-To: <5420A8F4.20909@redhat.com>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <20140922194841.GA9868@amd> <20140922203136.GA32156@srcf.ucam.org>
 <2486199.jzqMgLksH8@vostro.rjw.lan> <5420A8F4.20909@redhat.com>
Message-ID: <20140922230758.GA11987@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 04:55:48PM -0600, Al Stone wrote:

> Exactly so.  Or, collaborate with the hardware vendor, or a distro
> or anyone else that is a Promoter or Contributor as defined by UEFI
> [0].  The only thing to keep clear when doing so is who owns the
> intellectual property for any proposed change; this is one of the
> reasons the UEFI Forum has paid membership levels -- to pay for the
> legal assistance to make sure that the specs can be freely used.  As
> someone who is part of the ASWG, I'd personally be glad to help out
> however I can in this regard.

No, it's not about IP ownership, it's about whether those contributing 
the IP have waived patent rights. All contributors to a UEFI spec must 
be members - it's not acceptable for a member to contribute material on 
behalf of a non-member.

> I'm also curious as to what's being referred to as ACPI support
> code for large x86 vendors which is not part of the spec; I *think*
> I know what's being described but a specific example would really
> help me understand better.

Almost everything in drivers/platform/x86, the ACPI support code under 
drivers/gpu, the PCC code for HP servers, some of the USB-ACPI glue 
(defined by a Microsoft spec), some of the ACPI/TPM integration (defined 
by TCG), some hwmon code, probably a few other bits and pieces.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
