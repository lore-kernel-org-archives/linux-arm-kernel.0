From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Feb 2015 17:16:58 +0000
Subject: [PATCH] coresight-stm: adding driver for CoreSight STM component
In-Reply-To: <1423135651.27378.32.camel@x220>
References: <1423088550-15780-1-git-send-email-mathieu.poirier@linaro.org>
 <1423135651.27378.32.camel@x220>
Message-ID: <20150225171658.GF8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 12:27:31PM +0100, Paul Bolle wrote:
> I'm _guessing_ that CPU_32v4 and CPU_32v4T are needed for the ldrd and
> strd assembler instructions. If that's right a next _guess_ would be
> that you also need to mention CPU_32v3 here.

No.  Double word instructions are available in some ARMv5 (ARMv5TE and
up) and from ARMv6.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
