From: khilman@ti.com (Kevin Hilman)
Date: Wed, 09 May 2012 15:46:02 -0700
Subject: [PATCH 00/19] ARM: OMAP4 device off support
In-Reply-To: <1334914432-26456-1-git-send-email-t-kristo@ti.com> (Tero
 Kristo's message of "Fri, 20 Apr 2012 12:33:33 +0300")
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
Message-ID: <873979gehh.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> Hi,
>
> First version for this work. Applies on top of mainline + iochain set +
> OMAP4 core retention set. Working tree available here:
> tree: git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> branch: mainline-3.4-omap4-dev-off

FYI... seems your get repo is corrupted.  I tried fetching both with git
and https protocols:

$ git remote add tero git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
$ git fetch tero
fatal: The remote end hung up unexpectedly
fatal: protocol error: bad pack heade
$ git remote rm tero
$ git remote add tero https://git.gitorious.org/~kristo/omap-pm/omap-pm-work.git
$ git fetch tero
error: Unable to find 653621e4dd02d4a2117e1b813d9c5f1ccb11c9ed under https://git.gitorious.org/~kristo/omap-pm/omap-pm-work.git
Cannot obtain needed object 653621e4dd02d4a2117e1b813d9c5f1ccb11c9ed
error: Fetch failed.

Kevin
