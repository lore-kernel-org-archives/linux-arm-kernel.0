From: olof@lixom.net (Olof Johansson)
Date: Thu, 5 Mar 2015 10:11:31 -0800
Subject: [PATCH v9 09/21] ARM64 / ACPI: Introduce early_param "acpi=" to
 enable/disable ACPI
In-Reply-To: <1424853601-6675-10-git-send-email-hanjun.guo@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-10-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150305181131.GC4932@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 04:39:49PM +0800, Hanjun Guo wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> This implements the following policy to decide whether ACPI should
> be used to boot the system:
> - acpi=off: ACPI will not be used to boot the system, even if there is
>   no alternative available (e.g., device tree is empty)
> - acpi=force: only ACPI will be used to boot the system; if that fails,
>   there will be no fallback to alternative methods (such as device tree)
> - otherwise, ACPI will be used as a fallback if the device tree turns out
>   to lack a platform description; the heuristic to decide this is whether
>   /chosen is the only node present at depth 1
> 
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Olof Johansson <olof@lixom.net>



-Olof
