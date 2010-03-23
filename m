From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Tue, 23 Mar 2010 12:34:23 -0500
Subject: [PATCH v2 0/5] Mailbox: Fix some issues in mailbox module
In-Reply-To: <496565EC904933469F292DDA3F1663E602CA2B9B29@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602CA2B9B29@dlee06.ent.ti.com>
Message-ID: <4BA8FB9F.8080709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/18/2010 1:06 AM, Guzman Lugo, Fernando wrote:
>  From 79f2b477b19c49b36c51e8589c0a3d52ecd9ec99 Mon Sep 17 00:00:00 2001
> From: Fernando Guzman Lugo<x0095840@ti.com>
> Date: Thu, 18 Feb 2010 01:06:34 -0600
> Subject: [PATCH] Mailbox: Fix some issues in mailbox module
>
> This set of patches fix some issue I found when I was working
> with mailbox module.
>
> Fernando Guzman Lugo (4):
>    Mailbox: free mailbox interrupt before freeing blk queue
>    Mailbox: flush pending deferred works before freeing blk queue
>    Mailbox: Check valid registered callback before calling
>    Mailbox: disable mailbox interrupt when request queue
>
> Hiroshi DOYU (1):
>    Mailbox: new mutext lock for h/w mailbox configuration
>
>   arch/arm/plat-omap/mailbox.c |   29 ++++++++++++++++++++---------
>   1 files changed, 20 insertions(+), 9 deletions(-)
>

Cherry-picked until 2.6.34 rebase is available.

Pushed to dspbridge.

- omar
