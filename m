From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 28 May 2014 02:49:02 -0700
Subject: [PATCH 02/12] scsi/NCR5380: remove redundant HOSTS_C macro tests
In-Reply-To: <20140318004213.222484138@telegraphics.com.au>
References: <20140318004212.612472697@telegraphics.com.au>
 <20140318004213.222484138@telegraphics.com.au>
Message-ID: <20140528094902.GB26617@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 11:42:14AM +1100, Finn Thain wrote:
> HOSTS_C is always undefined. There is no hosts.c anymore.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
