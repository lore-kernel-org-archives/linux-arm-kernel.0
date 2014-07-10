From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 Jul 2014 11:08:03 +0100
Subject: [PATCH v10 0/3] arm64: Add audit support
In-Reply-To: <1404458911-8214-1-git-send-email-takahiro.akashi@linaro.org>
References: <1404458911-8214-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140710100803.GH16137@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 08:28:28AM +0100, AKASHI Takahiro wrote:
> This patchset adds system call audit support on arm64.
> Both 32-bit (AUDIT_ARCH_ARM) and 64-bit tasks (AUDIT_ARCH_AARCH64)
> are supported. Since arm64 has the exact same set of system calls
> on LE and BE, we don't care about endianness (or more specifically
> __AUDIT_ARCH_64BIT bit in AUDIT_ARCH_*).

Applied for 3.17. Thanks.

-- 
Catalin
