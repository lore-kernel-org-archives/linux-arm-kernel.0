From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 May 2014 10:10:13 +0100
Subject: [PATCH v10 3/3] ARM: Check if a CPU has gone offline
In-Reply-To: <1400127090-1320-4-git-send-email-ashwin.chaugule@linaro.org>
References: <1400127090-1320-1-git-send-email-ashwin.chaugule@linaro.org>
 <1400127090-1320-4-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <20140515091013.GD11117@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 05:11:30AM +0100, Ashwin Chaugule wrote:
> PSCIv0.2 adds a new function called AFFINITY_INFO, which
> can be used to query if a specified CPU has actually gone
> offline. Calling this function via cpu_kill ensures that
> a CPU has quiesced after a call to cpu_die. This helps
> prevent the CPU from doing arbitrary bad things when data
> or instructions are clobbered (as happens with kexec)
> in the window between a CPU announcing that it is dead
> and said CPU leaving the kernel.
> 
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
