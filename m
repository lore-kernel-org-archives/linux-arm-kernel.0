From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Sat, 23 Nov 2013 23:03:03 +0000
Subject: ACPI
In-Reply-To: <20131123183904.GB20790@obsidianresearch.com>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <528FC5C1.1080403@jonmasters.org> <528FCEA6.1060602@jonmasters.org>
 <201311231011.45892.arnd@arndb.de>
 <20131123183904.GB20790@obsidianresearch.com>
Message-ID: <20131123230303.GA5212@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 23, 2013 at 11:39:04AM -0700, Jason Gunthorpe wrote:

> However, fundamentally, that would mean that ACPI on the ARM is on-hold
> from a kernel perspective until the first spec is released by the new
> working group - and that would imply initial servers should plan to
> boot using DT, and provide experimental ACPI. Similar to how x86
> introduced ACPI.

Given a sufficiently well-defined platform (as Jon has hinted might be 
on the cards), there shouldn't really be any requirement to add any 
non-standardised ACPI support. Most of the ACPI-on-ARM work we've been 
talking about has been in order to provide a mechanism for booting a 
generic kernel on an ill-defined platform.

But, as it stands, the situation is still confusing. Different people 
who are interested in ACPI on ARM appear to want entirely different 
things, and it's not helped by this vague suggestion that server vendors 
want something entirely different from what Linaro have been working on 
and what we've been discussing at various points during recent 
conferences.

Jon, I know you're constrained by any number of hilarious NDAs, but this 
situation is currently fairly unworkable. The interest various people 
have in ensuring that ACPI on ARM is viable has been spurred on by your 
constant reassurances that server vendors are going to require it. But 
if we don't know what server vendors actually want then there's 
absolutely no guarantee that any of the work we're doing is going to be 
useful, and wasting time now is going to reduce people's ability to care 
in future. There's probably more ACPI expertise in the wider Linux 
community than anywhere else. Figure out a way to make use of it now, 
rather than relying on them to help you later.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
