From: will.deacon@arm.com (Will Deacon)
Date: Thu, 23 Feb 2012 22:59:24 +0000
Subject: [GIT PULL] Versatile Express DT support
In-Reply-To: <1330020005.2727.11.camel@hornet.cambridge.arm.com>
References: <1330020005.2727.11.camel@hornet.cambridge.arm.com>
Message-ID: <20120223225924.GA12404@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

On Thu, Feb 23, 2012 at 06:00:05PM +0000, Pawel Moll wrote:
> The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:
> 
>   Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)
> 
> are available in the git repository at:
>   git://git.linaro.org/people/pawelmoll/linux.git vexpress-dt-v3.3-rc4
> 
> Pawel Moll (8):
>       ARM: vexpress: Get rid of MMIO_P2V
>       ARM: versatile: Map local timers using Device Tree when possible
>       ARM: vexpress: Use FDT data in platform SMP calls

This patch has a curious commit message, which ends like:

	Signed-off-by: Pawel Moll <pawel.moll@arm.com>

	SMP update (change commit log!)

Is that last line supposed to be there?

Will
