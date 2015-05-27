From: geoff@infradead.org (Geoff Levand)
Date: Wed, 27 May 2015 09:32:29 -0700
Subject: ARM64 kexec/kdump timeline
In-Reply-To: <55653538.8020206@codeaurora.org>
References: <555E37FC.9020800@codeaurora.org>
 <1432239334.1922.7.camel@infradead.org> <55653538.8020206@codeaurora.org>
Message-ID: <1432744349.1922.19.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2015-05-26 at 22:08 -0500, Timur Tabi wrote:
> Does kexec on ARM64 support ACPI?  In some of our initial tests, it 
> appears that the kexec'd kernel won't boot because it's expecting a 
> device tree, and we don't have one.

I tested kexec re-boot on the foundation model with ACPI and it worked
OK.

I guess either your second stage kernel is not configured correctly, or
you did not invoke kexec correctly.  Check your dtb and command line
parameters.

-Geoff
