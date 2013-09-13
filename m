From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Sep 2013 15:26:19 +0100
Subject: [PATCH 120/228] cpufreq: sa11x0: don't initialize part of
 policy that is set by core too
In-Reply-To: <8e8853f66fadd4816a5d0fc5284c0c1b6a7816ba.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <8e8853f66fadd4816a5d0fc5284c0c1b6a7816ba.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <20130913142619.GT12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 06:31:06PM +0530, Viresh Kumar wrote:
> Many common initializations of struct policy are moved to core now and hence
> this driver doesn't need to do it. This patch removes such code.
> 
> Most recent of those changes is to call ->get() in the core after calling
> ->init().
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
