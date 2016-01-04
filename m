From: joe@perches.com (Joe Perches)
Date: Mon, 04 Jan 2016 14:11:37 -0800
Subject: [PATCH 3/3] checkpatch: add virt barriers
In-Reply-To: <20160104230528-mutt-send-email-mst@redhat.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
 <1451907395-15978-4-git-send-email-mst@redhat.com>
 <1451926073.4334.90.camel@perches.com>
 <20160104230528-mutt-send-email-mst@redhat.com>
Message-ID: <1451945497.4334.107.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-01-04 at 23:07 +0200, Michael S. Tsirkin wrote:
> On Mon, Jan 04, 2016 at 08:47:53AM -0800, Joe Perches wrote:
> > On Mon, 2016-01-04 at 13:37 +0200, Michael S. Tsirkin wrote:
> > > Add virt_ barriers to list of barriers to check for
> > > presence of a comment.
> > 
> > Are these virt_ barriers used anywhere?
> > 
> > I see some virtio_ barrier like uses.
> 
> They will be :) They are added and used by patchset
> 	????????arch: barrier cleanup + barriers for virt
> 
> See
> http://article.gmane.org/gmane.linux.kernel.virtualization/26555

Ah, OK, thanks.

Are the virtio_ barriers going away?
If not, maybe those should be added too.
