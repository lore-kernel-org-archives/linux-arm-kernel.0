From: matt@console-pimps.org (Matt Fleming)
Date: Thu, 9 Jan 2014 10:15:42 +0000
Subject: [PATCH v2 1/5] mm: create generic early_ioremap() support
In-Reply-To: <1389197388.29144.37.camel@deneb.redhat.com>
References: <1389062120-31896-1-git-send-email-msalter@redhat.com>
 <1389062120-31896-2-git-send-email-msalter@redhat.com>
 <52CC89B4.4060300@zytor.com>
 <1389197388.29144.37.camel@deneb.redhat.com>
Message-ID: <20140109101542.GD18441@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 08 Jan, at 11:09:48AM, Mark Salter wrote:
> 
> Ok, that sounds like a good idea. I'm uncertain how best to coordinate
> with Dave Young's patch series to avoid conflicts. His first patch does
> the signature change (and adds the early_memunmap function but that
> isn't used anywhere):
> 
>  https://lkml.org/lkml/2013/12/20/143
> 
> Any thoughts on how best to avoid potential merge conflicts here?

Dave's patch hasn't been picked up by anyone so far, so you could
incorporate it into your series.

-- 
Matt Fleming, Intel Open Source Technology Center
