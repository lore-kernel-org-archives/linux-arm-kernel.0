From: mst@redhat.com (Michael S. Tsirkin)
Date: Mon, 4 Jan 2016 23:07:13 +0200
Subject: [PATCH 3/3] checkpatch: add virt barriers
In-Reply-To: <1451926073.4334.90.camel@perches.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
 <1451907395-15978-4-git-send-email-mst@redhat.com>
 <1451926073.4334.90.camel@perches.com>
Message-ID: <20160104230528-mutt-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 08:47:53AM -0800, Joe Perches wrote:
> On Mon, 2016-01-04 at 13:37 +0200, Michael S. Tsirkin wrote:
> > Add virt_ barriers to list of barriers to check for
> > presence of a comment.
> 
> Are these virt_ barriers used anywhere?
> 
> I see some virtio_ barrier like uses.

They will be :) They are added and used by patchset
	        arch: barrier cleanup + barriers for virt

See
http://article.gmane.org/gmane.linux.kernel.virtualization/26555


-- 
MST
