From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Nov 2012 12:34:41 -0800
Subject: [PATCH V3 00/13] ARM: OMAP: DMTIMER fixes
In-Reply-To: <1352744444-2633-1-git-send-email-jon-hunter@ti.com>
References: <1352744444-2633-1-git-send-email-jon-hunter@ti.com>
Message-ID: <20121112203440.GL6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [121112 10:22]:
> This series includes several fixes for the OMAP DMTIMER driver. This is
> based upon Tony Lindgren's current master branch [1].

You should be able to use omap-for-v3.8/dt as the base now with
the cleanup merged there. The master branch is just a merge of the
various topic branches, and can't be used as a base for pull requests.

Regards,

Tony

> [1] http://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
