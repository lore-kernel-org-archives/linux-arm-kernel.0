From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Apr 2010 18:46:39 -0500
Subject: [PATCH v2 04/10] [ARM] tegra: SMP support
In-Reply-To: <1271198563-10424-5-git-send-email-konkers@android.com>
References: <1268721431-24434-1-git-send-email-konkers@google.com>
	<1271198563-10424-1-git-send-email-konkers@android.com>
	<1271198563-10424-2-git-send-email-konkers@android.com>
	<1271198563-10424-3-git-send-email-konkers@android.com>
	<1271198563-10424-4-git-send-email-konkers@android.com>
	<1271198563-10424-5-git-send-email-konkers@android.com>
Message-ID: <20100421234639.GA2593@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Minor nitpick, but if you're going to repost for other reasons it might
be worth to address:

On Tue, Apr 13, 2010 at 03:42:37PM -0700, konkers at android.com wrote:
> diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
> new file mode 100644
> index 0000000..b5349b2
> --- /dev/null
> +++ b/arch/arm/mach-tegra/headsmp.S
> @@ -0,0 +1,61 @@
> +#include <linux/linkage.h>
> +#include <linux/init.h>

Looks like this whole file uses spaces instead of tabs. You have a few other places
in the patchkit that does the same.


-Olof
