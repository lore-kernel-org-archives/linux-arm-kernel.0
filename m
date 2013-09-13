From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Sep 2013 15:29:37 +0100
Subject: [PATCH 039/228] cpufreq: sa11x0: let cpufreq core initialize
 struct policy fields
In-Reply-To: <8a36f8e32d7a9e9f4aa74db0525dbdc74fc023dd.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <8a36f8e32d7a9e9f4aa74db0525dbdc74fc023dd.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <20130913142937.GV12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 06:29:45PM +0530, Viresh Kumar wrote:
> Many fields of struct policy are filled by cpufreq core when we call
> cpufreq_table_validate_and_show() and so cpufreq driver doesn't need to set them
> anymore.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
