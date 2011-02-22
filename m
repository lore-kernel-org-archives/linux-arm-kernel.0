From: ccross@android.com (Colin Cross)
Date: Mon, 21 Feb 2011 23:05:52 -0800
Subject: [PATCH 6/6] ARM: tegra: add seaboard, wario and kaen boards
In-Reply-To: <1298354117-19097-7-git-send-email-olof@lixom.net>
References: <1298354117-19097-1-git-send-email-olof@lixom.net>
	<1298354117-19097-7-git-send-email-olof@lixom.net>
Message-ID: <AANLkTimJD8N=DdC1yRMcY35fmFLDMSEujMDS+UeQ_go6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 9:55 PM, Olof Johansson <olof@lixom.net> wrote:
> This adds board support for the Seaboard eval platform and some of the
> derivatives that are very similar. Since they only differ in some very
> minor ways, most of the code is shared.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>

<snip>

> +config MACH_SEABOARD
> + ? ? ? bool "Seaboard board family"
Nit: is the Seaboard a family or a board or both?  If both, maybe
"Seaboard and family of related boards" or something similar?

<snip>

> +#include <mach/io.h>
linux/io.h?

Other than that, Acked-by: Colin Cross <ccross@android.com>
