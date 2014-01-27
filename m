From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jan 2014 14:37:45 +0000
Subject: [PATCH 1/9] ARM: dts: imx6qdl: remove the use of pingrp macros
In-Reply-To: <1390668191-20289-2-git-send-email-shawn.guo@linaro.org>
References: <1390668191-20289-1-git-send-email-shawn.guo@linaro.org>
 <1390668191-20289-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20140127143745.GM15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 26, 2014 at 12:43:03AM +0800, Shawn Guo wrote:
>  arch/arm/boot/dts/imx6dl-hummingboard.dts  |    5 +-
>  arch/arm/boot/dts/imx6qdl-microsom.dtsi    |    5 +-

I've merged your changes here into my local copy of these just to reduce
the conflicts - unfortunately, it's taken soo long to deal with the above
that the cubox-i has now been released, which has prompted some
reorganisation between the above two files.

I would much rather you dropped these two entirely, and let me push them
upstream, rather than having some nasty conflicts which result from this.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
