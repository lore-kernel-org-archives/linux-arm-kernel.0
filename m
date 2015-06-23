From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 23 Jun 2015 08:08:22 +0100
Subject: [PATCH 5/8] ARM: STi: STiH407: Move PWM nodes STiH407 =>
 STiH407-family
In-Reply-To: <20150623021708.GB16776@linux>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-6-git-send-email-lee.jones@linaro.org>
 <20150623021708.GB16776@linux>
Message-ID: <20150623070822.GB3245@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Jun 2015, Viresh Kumar wrote:
> On 22-06-15, 16:43, Lee Jones wrote:
> > This also incorporates the STiH410.
> 
> Any explanation to why this patch is part of this series ?

Because the CPUFreq regulator is controlled with PWM and CPUFreq will
fail on STiH410 (my main development platform) without it.

It's safe for you to ignore it though.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
