From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Dec 2010 14:42:14 -0800
Subject: [PATCH v3] OMAP3: clean up ASM idle code
In-Reply-To: <1292347603-17703-1-git-send-email-j-pihet@ti.com>
References: <1292347603-17703-1-git-send-email-j-pihet@ti.com>
Message-ID: <20101214224214.GB14990@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

* jean.pihet at newoldbits.com <jean.pihet@newoldbits.com> [101214 09:28]:
> From: Jean Pihet <j-pihet@ti.com>
> 
> This patch only contains clean-ups and cosmetic changes,
> no functional change.
> 
> Clean up of the ASM code:
> - reorganized the code in logical sections: defines, API
>    functions, internal functions and variables,
> - reworked and simplified the execution paths, for better
>    readability and to avoid duplication of code,
> - added comments on the entry and exit points and the interaction
>    with the ROM code for OFF mode restore,
> - reworked the existing comments for better readability,
> - reworked the code formating, alignment and white spaces,
> - added comments for the i443 erratum workarounds,
> - changed the hardcoded values in favor of existing macros
>    from include files,
> - clean up of non used symbols.

Can you please split it further, it's not obvious from reading it
that it does not change anything.

How about first do one or more patches to move the code around.
Then rework the comments and formatting.

Thanks,

Tony
