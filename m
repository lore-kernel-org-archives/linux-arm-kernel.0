From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 10 Mar 2016 10:12:01 -0600
Subject: [PATCH 0/8] EFI framebuffer support for ARM and arm64
In-Reply-To: <1457588408-19309-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1457588408-19309-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <56E19CD1.6080409@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2016 11:40 PM, Ard Biesheuvel wrote:
> This series adds support to ARM and arm64 for using the kernel's EFI
> framebuffer driver to drive EFI Graphics Output Protocol (GOP) based
> framebuffers.
>
> This involves refactoring some of the existing x86 code so it can be reused
> by ARM and arm64, and wiring it up both in the UEFI stub and in the core
> kernel into the existing UEFI infrastructure for ARM and arm64.

Given that I have access to a variety of different ARM64 UEFI
implementations, how would I go about testing this code? Do I
need a specific UEFI implementation and are there any special
command line arguments I should pass to the kernel?

--Mark Langsdorf
