From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Jun 2015 16:01:28 +0100
Subject: [PATCH] ARM: Re-enable TRACE_IRQFLAGS_SUPPORT on ARMv7-M
In-Reply-To: <5576D0FE.10900@linaro.org>
References: <1433802288-25508-1-git-send-email-mcoquelin.stm32@gmail.com>
 <20150608224749.GB7557@n2100.arm.linux.org.uk>
 <CALszF6DPzhAufUyWW-a3X7Cp4=tjSyCBM=Y4LcnWnUH=41qeoQ@mail.gmail.com>
 <5576D0FE.10900@linaro.org>
Message-ID: <20150609150127.GF7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 12:41:50PM +0100, Daniel Thompson wrote:
> Does the following patch, which makes the arch_irqs_disabled()
> implementation from asm-generic available on arm, fix the build for you?

Yes, this is exactly the kind of fix for this I'm looking for.  Once
everyone's happy with it, it can find it's way to the patch system.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
