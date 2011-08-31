From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 31 Aug 2011 13:44:32 +0100
Subject: [PATCH 1/5] ARM: Samsung: PWM: Allow to differentiate SoCs
	based on platform device name.
In-Reply-To: <4002702.FticUbImag@flatron>
References: <1731819.jJi37IsjvJ@flatron>
 <4002702.FticUbImag@flatron>
Message-ID: <20110831124432.GF14976@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2011 at 02:34:15PM +0200, Tomasz Figa wrote:

> This patch is a prerequisite to adding generic time support for S3C64xx.
> It makes possible to differentiate SoCs, required to exclude timers 3 and 4
> from PWM driver only on S3C64xx.

Now we have the cpu_is_foo() support for Samsung CPUs can we use that
instead?
