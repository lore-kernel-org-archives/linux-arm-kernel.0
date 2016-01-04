From: joe@perches.com (Joe Perches)
Date: Mon, 04 Jan 2016 08:47:53 -0800
Subject: [PATCH 3/3] checkpatch: add virt barriers
In-Reply-To: <1451907395-15978-4-git-send-email-mst@redhat.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
 <1451907395-15978-4-git-send-email-mst@redhat.com>
Message-ID: <1451926073.4334.90.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-01-04 at 13:37 +0200, Michael S. Tsirkin wrote:
> Add virt_ barriers to list of barriers to check for
> presence of a comment.

Are these virt_ barriers used anywhere?

I see some virtio_ barrier like uses.
