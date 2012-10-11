From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Oct 2012 07:40:29 +0000
Subject: Multiplatform Kconfig options
In-Reply-To: <1349931799.7978.3.camel@gitbox>
References: <1349931799.7978.3.camel@gitbox>
Message-ID: <201210110740.29497.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 October 2012, Tony Prisk wrote:
> What is the preference for multiplatform-enabled arch/Kconfig's?
> 
> Should we be specifying options that are already enabled by
> multiplatform or can we assume they will always be enabled?
> 
> It 'feels' safer to explicitly enable them to catch problems later when
> things are changed and people forget :)
> 
> Examples: MULTI_IRQ_HANDLER, SPARSE_IRQ, USE_OF, COMMON_CLK...

They won't just go away from CONFIG_MULTIPLATFORM, no need to enable
them yourself. We also have a lot of options that are unconditionally
enabled for all ARM platforms.

	Arnd
