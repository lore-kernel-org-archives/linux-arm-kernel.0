From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 5 Feb 2014 11:48:32 +0000
Subject: [PATCH] security: select correct default LSM_MMAP_MIN_ADDR on
 arm on arm64
In-Reply-To: <1391480133-27149-1-git-send-email-ccross@android.com>
References: <1391480133-27149-1-git-send-email-ccross@android.com>
Message-ID: <20140205114832.GB7550@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 02:15:32AM +0000, Colin Cross wrote:
> Binaries compiled for arm may run on arm64 if CONFIG_COMPAT is
> selected.  Set LSM_MMAP_MIN_ADDR to 32768 if ARM64 && COMPAT to
> prevent selinux failures launching 32-bit static executables that
> are mapped at 0x8000.
> 
> Signed-off-by: Colin Cross <ccross@android.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
