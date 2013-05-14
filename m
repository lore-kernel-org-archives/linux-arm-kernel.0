From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 14 May 2013 12:31:21 +0100
Subject: [PATCH v2 2/3] ARM: nommu: re-enable use of vexpress without
 ARCH_MULTIPLATFORM
In-Reply-To: <1368530845-7415-3-git-send-email-jonathan.austin@arm.com>
References: <1368530845-7415-1-git-send-email-jonathan.austin@arm.com>
 <1368530845-7415-3-git-send-email-jonathan.austin@arm.com>
Message-ID: <1368531081.3159.2.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-05-14 at 12:27 +0100, Jonathan Austin wrote:
> Since 617276307cd4c ("ARM: vexpress: convert to multi-platform") it has been
> impossible to select ARCH_VEXPRESS without ARCH_MULTIPLATFORM.
> 
> ARCH_MULTIPLATFORM doesn't make sense for NOMMU targets, not least because
> of the need to hard-code the memory map. However, it should still be
> possible to run NOMMU kernels on top of the Versatile Express by selecting
> it as the only platform.
> 
> This patch creates a shim ARCH_VEXPRESS_NOMMU config option in the 'choice'
> for "ARM system type" to make this possible again.
> 
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Nicolas Pitre <nico@fluxnic.net>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> CC: Pawel Moll <pawel.moll@arm.com>

Acked-by: Pawel Moll <pawel.moll@arm.com>

Thanks!

Pawel
