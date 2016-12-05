From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 5 Dec 2016 11:09:20 +0800
Subject: [PATCH V2 fix 4/6] mm: mempolicy: intruduce a helper
 huge_nodemask()
In-Reply-To: <20161202135845.GL6830@dhcp22.suse.cz>
References: <1479107259-2011-5-git-send-email-shijie.huang@arm.com>
 <1479279182-31294-1-git-send-email-shijie.huang@arm.com>
 <20161202135845.GL6830@dhcp22.suse.cz>
Message-ID: <20161205030918.GA13468@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 02:58:46PM +0100, Michal Hocko wrote:
> On Wed 16-11-16 14:53:02, Huang Shijie wrote:
> > This patch intruduces a new helper huge_nodemask(),
> > we can use it to get the node mask.
> > 
> > This idea of the function is from the init_nodemask_of_mempolicy():
> >    Return true if we can succeed in extracting the node_mask
> > for 'bind' or 'interleave' policy or initializing the node_mask
> > to contain the single node for 'preferred' or 'local' policy.
> 
> It is absolutely unclear how this is going to be used from this patch.
> Please make sure to also use a newly added function in the same patch.
> 
Okay, I will merge this patch into the later patch.

Thanks	
Huang Shijie	
