From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 10:17:52 +0100
Subject: [PATCH] branch tracer: fix freak link error
In-Reply-To: <20160215152639.7795795c@gandalf.local.home>
References: <1455312410-1058841-1-git-send-email-arnd@arndb.de>
 <2535125.MjntUgx4sh@wuerfel> <20160215152639.7795795c@gandalf.local.home>
Message-ID: <3821446.rAiXri9yEZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 February 2016 15:26:39 Steven Rostedt wrote:
> On Mon, 15 Feb 2016 21:15:39 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > Do you also want to add a 'Cc: stable at vger.kernel.org' tag?
> > 
> 
> I currently have this in the Tags:
> 
>     Acked-by: Nicolas Pitre <nico@linaro.org>
>     Fixes: ab3c9c686e22 ("branch tracer, intel-iommu: fix build with CONFIG_BRANCH_TRACER=y")
>     Cc: stable at vger.kernel.org # v2.6.30+
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>     Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 

Looks good, thanks!

	Arnd
