From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Feb 2012 14:56:03 +0000
Subject: [GIT PULL] Versatile Express DT support
In-Reply-To: <1330020005.2727.11.camel@hornet.cambridge.arm.com>
References: <1330020005.2727.11.camel@hornet.cambridge.arm.com>
Message-ID: <201202241456.03306.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 February 2012, Pawel Moll wrote:
> Hello Arnd, Olof,
> 
> Please pull the Versatile Express DT patches, rebased on top of
> v3.3-rc4. I think I addressed all the comments I received:
> - fixed the difference between DT and non-DT machine name (missing '-')
> - as probing DEBUG_LL UART address proved to be unsafe, it is now
> determined based on a PERIPHBASE register, which can be safely checked
> - DTS don't include skeleton.dtsi any more, so there is no bogus memory
> node
> - changed TWD bindings to be in line with Marc Zygier's series
> - as the static mappings are now reused, all pointer arithmetic was
> replaced with ioremap()s
> 
> First patch causes one trivial conflict with depends/rmk/for-armsoc (for
> your reference, I resolved it in vexpress-dt-rmk-for-armsoc branch)
> 
> Thanks!
> 
> Pawel
> 
> The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:
> 
>   Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)
> 
> are available in the git repository at:
>   git://git.linaro.org/people/pawelmoll/linux.git vexpress-dt-v3.3-rc4

Hi Pawel,

I've applied the series to the next/dt branch in arm-soc now,
thanks a lot!

	Arnd
