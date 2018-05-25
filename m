From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 25 May 2018 11:04:50 +0100
Subject: [PATCH v4 02/26] arm64: cpufeature: Add cpufeature for IRQ
 priority masking
In-Reply-To: <1527241772-48007-3-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
 <1527241772-48007-3-git-send-email-julien.thierry@arm.com>
Message-ID: <e44df12f-9868-ae94-4623-ec221d72d783@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/05/18 10:49, Julien Thierry wrote:
> Add a cpufeature indicating whether a cpu supports masking interrupts
> by priority.

How is this different from the SYSREG_GIC_CPUIF cap ? Is it just
the description ?

Suzuki
