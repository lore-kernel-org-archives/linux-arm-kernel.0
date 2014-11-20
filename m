From: geoff.levand@linaro.org (Geoff Levand)
Date: Wed, 19 Nov 2014 17:27:07 -0800
Subject: [PATCH v3 00/13] arm64: stable UEFI mappings for kexec
In-Reply-To: <1416315432-8534-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1416315432-8534-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1416446827.23886.95.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Tue, 2014-11-18 at 13:56 +0100, Ard Biesheuvel wrote:
> This is v3 of the series to update the UEFI memory map handling for the arm64
> architecture so that:

Just to let you know, I merged these into my kexec master branch [1] and
could do a kexec re-boot on a non-EFI system (VE fast model).  I'll try
with EFI enabled firmware next.

[1] https://git.linaro.org/people/geoff.levand/linux-kexec.git

-Geoff
