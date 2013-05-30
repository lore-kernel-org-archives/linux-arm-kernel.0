From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 30 May 2013 16:41:12 -0600
Subject: build failure: linux-next: ARM defconfigs: imx_v4_v5, imx_v6_v7
In-Reply-To: <87fvx43xpd.fsf@linaro.org>
References: <87fvx43xpd.fsf@linaro.org>
Message-ID: <51A7D588.1070605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2013 04:33 PM, Kevin Hilman wrote:
> Hello,
> 
> The SPI driver for IMX started failing in linux-next (next-20130530)
> where the previous tag build fine.  Below is the build error[1],
> followed by the the commit[2] that I think introduced the problem.  It
> appears to be some missing (or extra) curly braces.

Sorry about that. Sachin Kamat <sachin.kamat@linaro.org> has already
sent a patch, which Mark has applied, so this should be fixed in the
next linux-next. Unfortunately, linux-spi at vger.kernel.org doesn't seem
to be archived anywhere, so I can't link to it. Oh, I guess gitweb has it:

https://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/commit/?h=topic/bpw&id=6051426fd0538eac4e28c55a08e4f4fb1c709b65
