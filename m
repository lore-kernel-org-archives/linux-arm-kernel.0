From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 Aug 2014 16:01:25 +0800
Subject: ARM: mx28: cpufreq-cpu0 support?
In-Reply-To: <53F9B4BF.2050802@lategoodbye.de>
References: <53F9B4BF.2050802@lategoodbye.de>
Message-ID: <20140825080123.GA12289@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 24, 2014 at 11:47:43AM +0200, Stefan Wahren wrote:
> Hi,
> 
> could you please tell me, is i.MX28 supported by cpufreq-cpu0?
> 
> Do we need only the necessary DT entries like operating points or is
> it more?

Clock might as simple as adding DT entries, but I'm not sure we have
voltage scaling support for i.MX28 in kernel.

Shawn
