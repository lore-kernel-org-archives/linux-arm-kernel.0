From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Nov 2011 09:49:25 +0000
Subject: [PATCH V3 3/6] ARM: exynos: save L2 settings during bootup
In-Reply-To: <1321954532-18724-4-git-send-email-amit.kachhap@linaro.org>
References: <1321954532-18724-1-git-send-email-amit.kachhap@linaro.org>
 <1321954532-18724-4-git-send-email-amit.kachhap@linaro.org>
Message-ID: <20111122094925.GV9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 03:05:29PM +0530, Amit Daniel Kachhap wrote:
> This patch adds code to save L2 register configuration at boot, and
> later used to resume L2 before MMU is enabled in suspend and cpuidle
> resume paths.

Is there a reason exynos isn't using the generic l2 code?
