From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Jan 2017 16:41:02 +0100
Subject: [GIT PULL] drivers: firmware: PSCI fixes for v4.10
In-Reply-To: <20170103185052.GA23238@e107981-lin.cambridge.arm.com>
References: <20170103185052.GA23238@e107981-lin.cambridge.arm.com>
Message-ID: <9731264.DqPvkZ2h7v@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 3, 2017 6:50:52 PM CET Lorenzo Pieralisi wrote:
> PSCI fixes for v4.10
> 
> Two minor fixes following the merge of the PSCI checker:
> 
> - Annotate the PSCI checker timer on the stack used to wake-up from
>   suspend to prevent warnings when the DEBUG_OBJECTS config option
>   is enabled
> - Extend the PSCI entry in the maintainers list to also include the
>   PSCI checker code
> 

Pulled into fixes, thanks!

	Arnd
