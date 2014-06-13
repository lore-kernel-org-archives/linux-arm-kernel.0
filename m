From: joe@perches.com (Joe Perches)
Date: Fri, 13 Jun 2014 09:14:34 -0700
Subject: [PATCH V2 00/19] irqchip: crossbar: driver fixes
In-Reply-To: <20140613150122.GP8664@titan.lakedaemon.net>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <20140613150122.GP8664@titan.lakedaemon.net>
Message-ID: <1402676074.12385.40.camel@joe-AO725>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-06-13 at 11:01 -0400, Jason Cooper wrote:
> Please format the subject lines like so:
> 
>   irqchip: crossbar: Set cb pointer ...
>                      ^
>                      |
>                      \-- note the capitalization

I suggest you don't make this a rule and focus
on more important stuff instead.

Nobody is going to write tools that parse the
changelogs by "git log --format=%s" for case
sensitivity.

As is, it's about half/half.

$ git log --format=%s --no-merges drivers/irqchip/ | \
  grep "^irqchip:" | cut -f3- -d":"
