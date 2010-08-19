From: arjan@linux.intel.com (Arjan van de Ven)
Date: Wed, 18 Aug 2010 21:38:34 -0700
Subject: [PATCHv2 2/1] Consolidate CONFIG_DEBUG_STRICT_USER_COPY_CHECKS
In-Reply-To: <1282184898-30599-1-git-send-email-sboyd@codeaurora.org>
References: <201008181428.45029.arnd@arndb.de>
	<1282184898-30599-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <4C6CB54A.4090605@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/18/2010 7:28 PM, Stephen Boyd wrote:
> The help text for this config is duplicated across the x86,
> parisc, s390, and arm Kconfig.debug files. Arnd Bergman noted
> that the help text was slightly misleading and should be fixed to
> state that enabling this option isn't a problem when using pre 4.4
> gcc.
>
> To simplify the rewording, consolidate the text into
> lib/Kconfig.debug and modify it there to be more explicit about
> when you should say N to this config.
>    


Acked-by: Arjan van de Ven <arjan@linux.intel.com>
