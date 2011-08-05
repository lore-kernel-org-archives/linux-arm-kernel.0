From: khilman@ti.com (Kevin Hilman)
Date: Fri, 05 Aug 2011 07:52:44 -0700
Subject: [PATCH] OMAP: omap_device: make latency autoadjust messages debug
In-Reply-To: <1311599904-5981-1-git-send-email-notasas@gmail.com> (Grazvydas
	Ignotas's message of "Mon, 25 Jul 2011 16:18:24 +0300")
References: <1311599904-5981-1-git-send-email-notasas@gmail.com>
Message-ID: <874o1vvrk3.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grazvydas Ignotas <notasas@gmail.com> writes:

> During normal system operation warning messages similar to this
> are appearing quite often:
> omap_device: omap4-keypad.-1: new worst case activate latency 0: 61035
>
> This doesn't seem to be reporting a problem, nor is it very useful for
> non-developers, so reduce it to debug level.

Yeah, this is really only useful for PM developers, so making it debug
is fine.

> Cc: Steve Sakoman <steve@sakoman.com>
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
> Applies on top of git://git.pwsan.com/linux-2.6 prcm-devel-3.1
> + Kevin's "OMAP: omap_device: replace pr_* prints with dev_*".

Adding it to my omap_device queue for v3.2:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.2/omap_device

Kevin
