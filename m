From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 31 Mar 2015 09:15:22 +0200
Subject: [PATCH] sata_mv: Manage SATA port multiplier while searching
 for active links
In-Reply-To: <20150330173515.GC9974@htj.duckdns.org>
References: <1427736765-846-1-git-send-email-gregory.clement@free-electrons.com>
 <20150330173515.GC9974@htj.duckdns.org>
Message-ID: <551A498A.2010008@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tejun,

On 30/03/2015 19:35, Tejun Heo wrote:
> Hello,
> 
> On Mon, Mar 30, 2015 at 07:32:45PM +0200, Gregory CLEMENT wrote:
>> From: Nadav Haklai <nadavh@marvell.com>
>>
>> With this patch, when searching for active link, first search through
>> the port multiplier links. And then fall to the default ap active_tag
>> only if no there is no active link in the port multiplier.
> 
> What does this fix?  What was broken before?  What's the impact of the
> patch?  A patch description which just restates the patch content
> isn't all that useful.

I _thought_ that the purpose of this patch was to manage the port multiplier,
and without this patch we don't only handle it. I will ask more detail and
come back with a new version of the patch with a more useful description.

Thanks,

Gregory



> 
> Thanks.
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
