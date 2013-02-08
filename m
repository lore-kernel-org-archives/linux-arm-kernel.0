From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 08 Feb 2013 15:56:53 +0000
Subject: vexpress_sysreg_probe section mismatch with 3.8-rc6
In-Reply-To: <20130208120648.GB3495@mudshark.cambridge.arm.com>
References: <20130208120648.GB3495@mudshark.cambridge.arm.com>
Message-ID: <1360339013.4045.53.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-02-08 at 12:06 +0000, Will Deacon wrote:
> My guess is that you don't want the __init annotation on
> vexpress_sysreg_setup; patch below.

It's already fixed in arm-soc:

http://git.kernel.org/?p=linux/kernel/git/arm/arm-soc.git;a=commitdiff;h=e065d3d417274bafed162b3dffd2e03a5128623c

Cheers!

Pawel
