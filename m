From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Jan 2014 15:07:25 +0000
Subject: [PATCH v2 resend 1/5] ARM: add support for AT_HWCAP2 ELF auxv
 entry
In-Reply-To: <1389950591-4212-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1389950591-4212-1-git-send-email-ard.biesheuvel@linaro.org>
 <1389950591-4212-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140117150725.GK16003@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Fri, Jan 17, 2014 at 09:23:07AM +0000, Ard Biesheuvel wrote:
> This enables AT_HWCAP2 for ARM. The generic support for this
> new ELF auxv entry was added in commit 2171364d1a9 (powerpc:
> Add HWCAP2 aux entry)

Does this require a corresponding change in libc so that the entry is
actually used by the dynamic linker?

Will
