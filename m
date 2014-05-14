From: will.deacon@arm.com (Will Deacon)
Date: Wed, 14 May 2014 10:03:25 +0100
Subject: [PATCH v2] ARM64: kernel: add compatible cpuinfo
In-Reply-To: <1400036894-16667-1-git-send-email-zhangwm@marvell.com>
References: <1400036894-16667-1-git-send-email-zhangwm@marvell.com>
Message-ID: <20140514090325.GB9910@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 04:08:14AM +0100, Neil Zhang wrote:
> Print the necessary features in order to be backwards compatible with
> ARMv7 and earlier version.

NAK. The compat hwcaps are already advertised in auxv, and I don't have any
plans to align our /proc/cpuinfo format.

Will
