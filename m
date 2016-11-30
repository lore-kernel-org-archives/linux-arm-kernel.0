From: shijie.huang@arm.com (Huang Shijie)
Date: Wed, 30 Nov 2016 11:03:42 +0800
Subject: [PATCH v2 1/6] mm: hugetlb: rename some allocation functions
In-Reply-To: <d28b825d-1026-1e91-fa4e-395df3e1be86@suse.cz>
References: <1479107259-2011-1-git-send-email-shijie.huang@arm.com>
 <1479107259-2011-2-git-send-email-shijie.huang@arm.com>
 <52b661c9-f4b0-3d94-cf9b-a0ffd5ecb723@suse.cz>
 <20161129085349.GA16569@sha-win-210.asiapac.arm.com>
 <d28b825d-1026-1e91-fa4e-395df3e1be86@suse.cz>
Message-ID: <20161130030341.GB18502@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 11:44:23AM +0100, Vlastimil Babka wrote:
> On 11/29/2016 09:53 AM, Huang Shijie wrote:
> > On Mon, Nov 28, 2016 at 02:29:03PM +0100, Vlastimil Babka wrote:
> > > On 11/14/2016 08:07 AM, Huang Shijie wrote:
> > > >  static inline bool gigantic_page_supported(void) { return true; }
> > > >  #else
> > > > +static inline struct page *alloc_gigantic_page(int nid, unsigned int order)
> > > > +{
> > > > +	return NULL;
> > > > +}
> > > 
> > > This hunk is not explained by the description. Could belong to a later
> > > patch?
> > > 
> > 
> > Okay, I can create an extra patch to add the description for the
> > alloc_gigantic_page().
> 
> Not sure about extra patch, just move it to an existing later patch that
> relies on it?
The whole patch set has been merged to Andrew's tree, so an extra patch
is better. :)

Thanks
Huang Shijie
