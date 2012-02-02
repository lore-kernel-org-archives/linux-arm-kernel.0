From: khilman@ti.com (Kevin Hilman)
Date: Thu, 02 Feb 2012 11:23:09 -0800
Subject: [PATCH v3 00/20] ARM: OMAP3+: SmartReflex: bugfixes
In-Reply-To: <1328086199-28486-1-git-send-email-j-pihet@ti.com> (Jean Pihet's
 message of "Wed, 1 Feb 2012 09:49:39 +0100")
References: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Message-ID: <871uqdca5e.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Integrate the latest SmartReflex bufixes from Felipe Balbi [1] and
> Nishant Menon [2], plus misc bugfixes.
>
> Based on latest master branch of the mainline git tree (3.3.0-rc1) [3], commit
> 27ba234c8dfe86c96675d4ef275d1d3c1f5f7053.
>
> [1] http://marc.info/?l=linux-omap&m=132134699423547&w=2
> [2] https://github.com/nmenon/linux-omap-ti-pm/commits/linux-omap-3.0
> [3] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=shortlog

Can you break this series up further?

There is lots of stuff in this series that does not qualify as a fix or
a cleanup.  (specifically, all the ones starting with "introduce...").

We need to keep fixes and cleanups separate from new features.

Kevin
