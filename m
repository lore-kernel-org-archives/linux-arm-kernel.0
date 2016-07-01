From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 01 Jul 2016 23:09:31 +0200
Subject: [PATCH v2] PM / suspend: show workqueue state in suspend flow
In-Reply-To: <20160701160942.GC28719@htj.duckdns.org>
References: <1467342302-16129-1-git-send-email-roger.lu@mediatek.com>
 <20160701160942.GC28719@htj.duckdns.org>
Message-ID: <2215954.JsBGX7yoLs@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 01, 2016 11:09:42 AM Tejun Heo wrote:
> On Fri, Jul 01, 2016 at 11:05:02AM +0800, Roger Lu wrote:
> > If freezable workqueue aborts suspend flow, show
> > workqueue state for debug purpose.
> > 
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Rafael, can you please pick this on up?

I will.

Thanks,
Rafael
