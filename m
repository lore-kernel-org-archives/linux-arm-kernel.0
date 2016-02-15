From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 15 Feb 2016 15:26:39 -0500
Subject: [PATCH] branch tracer: fix freak link error
In-Reply-To: <2535125.MjntUgx4sh@wuerfel>
References: <1455312410-1058841-1-git-send-email-arnd@arndb.de>
 <20160215124746.44e8c2d0@gandalf.local.home>
 <2535125.MjntUgx4sh@wuerfel>
Message-ID: <20160215152639.7795795c@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Feb 2016 21:15:39 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> Do you also want to add a 'Cc: stable at vger.kernel.org' tag?
> 

I currently have this in the Tags:

    Acked-by: Nicolas Pitre <nico@linaro.org>
    Fixes: ab3c9c686e22 ("branch tracer, intel-iommu: fix build with CONFIG_BRANCH_TRACER=y")
    Cc: stable at vger.kernel.org # v2.6.30+
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
