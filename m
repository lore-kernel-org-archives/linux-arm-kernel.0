From: mgorman@techsingularity.net (Mel Gorman)
Date: Fri, 11 Aug 2017 10:50:09 +0100
Subject: [v6 04/15] mm: discard memblock data later
In-Reply-To: <20170811093249.GE30811@dhcp22.suse.cz>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-5-git-send-email-pasha.tatashin@oracle.com>
 <20170811093249.GE30811@dhcp22.suse.cz>
Message-ID: <20170811095009.hz2vnatcwztffraw@techsingularity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 11, 2017 at 11:32:49AM +0200, Michal Hocko wrote:
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> > Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
> > Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> > Reviewed-by: Bob Picco <bob.picco@oracle.com>
> 
> Considering that some HW might behave strangely and this would be rather
> hard to debug I would be tempted to mark this for stable. It should also
> be merged separately from the rest of the series.
> 
> I have just one nit below
> Acked-by: Michal Hocko <mhocko@suse.com>
> 

Agreed.

-- 
Mel Gorman
SUSE Labs
