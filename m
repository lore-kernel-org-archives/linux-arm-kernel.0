From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Fri, 29 Jul 2011 16:25:58 +0530
Subject: [PATCH v4 REPOST 18/20] gpio/omap: use pm-runtime framework
In-Reply-To: <20110728170029.GA9819@google.com>
References: <1310804152-9243-1-git-send-email-tarun.kanti@ti.com>
	<1310804152-9243-19-git-send-email-tarun.kanti@ti.com>
	<20110716190734.GB990@google.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB037C202D59@dbde02.ent.ti.com>
	<20110728074327.GA12916@google.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB037C2030F7@dbde02.ent.ti.com>
	<20110728170029.GA9819@google.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037C374A45@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
> To be clear, it seems like resetting irqenable settings should be a
> one-time action at probe time.  The power management actions such as
Looking at it again, well we could probably avoid *_mod_init() in request.
I will test and confirm. Thanks.
--
Tarun
[...]
> 
> Anyhow, mainly wanted to point that out as a possible optimization.
> It's pretty unlikely there's an actual problem here.
> 
> 
> Todd
