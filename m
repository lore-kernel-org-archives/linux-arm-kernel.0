From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Oct 2017 15:29:08 +0100
Subject: [PATCH v3 08/28] arm64/sve: Kconfig update and conditional
 compilation support
In-Reply-To: <1507660725-7986-9-git-send-email-Dave.Martin@arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-9-git-send-email-Dave.Martin@arm.com>
Message-ID: <20171011142908.gwgxegzy2kyb5i3t@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 07:38:25PM +0100, Dave P Martin wrote:
> This patch adds CONFIG_ARM64_SVE to control building of SVE support
> into the kernel, and adds a stub predicate system_supports_sve() to
> control conditional compilation and runtime SVE support.
> 
> system_supports_sve() just returns false for now: it will be
> replaced with a non-trivial implementation in a later patch, once
> SVE support is complete enough to be enabled safely.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
