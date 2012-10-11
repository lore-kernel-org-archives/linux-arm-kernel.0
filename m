From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 11 Oct 2012 18:03:19 +1300
Subject: Multiplatform Kconfig options
Message-ID: <1349931799.7978.3.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

What is the preference for multiplatform-enabled arch/Kconfig's?

Should we be specifying options that are already enabled by
multiplatform or can we assume they will always be enabled?

It 'feels' safer to explicitly enable them to catch problems later when
things are changed and people forget :)

Examples: MULTI_IRQ_HANDLER, SPARSE_IRQ, USE_OF, COMMON_CLK...


Regards
Tony P
