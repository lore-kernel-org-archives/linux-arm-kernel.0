From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Dec 2013 17:32:14 +0000
Subject: [PATCH 0/3] ARM64: add perf support
In-Reply-To: <1387212873-8248-1-git-send-email-jean.pihet@linaro.org>
References: <1387212873-8248-1-git-send-email-jean.pihet@linaro.org>
Message-ID: <20131216173214.GK20193@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean,

On Mon, Dec 16, 2013 at 04:54:30PM +0000, Jean Pihet wrote:
> Add perf support for the AARCH64 architecture. This includes the
> support for:

To be fair, we do have perf support already. This is extending what we have
by adding additional arch-specific stuff.

> - AARCH64 perf registers definition and hooks,
> - compat mode registers use, i.e. profiling a 32-bit binary on
>    a 64-bit system,
> - unwinding using the dwarf information from the .debug_frame
>    section of the ELF binary; only in 64-bit mode,
> - unwinding using the frame pointer information; in 64-bit and
>    compat modes.

Why did you send out two copies of this series to different lists? Which one
should I be looking at?

/confused

Will
