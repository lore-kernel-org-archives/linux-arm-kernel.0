From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 25 Sep 2018 08:42:33 +0800
Subject: clean up physical merging helpers V2
In-Reply-To: <20180924074355.2802-1-hch@lst.de>
References: <20180924074355.2802-1-hch@lst.de>
Message-ID: <20180925004232.GC14386@ming.t460p>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2018 at 09:43:45AM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series moves various helpers related to merging based on physical
> addresses from the public headers into block/, cleans up the code a bit
> and removes not nessecary includes from the block headers.
> 
> Change since V1:
>  - dropped the Xen related changed which are moved into a new series
>    to be sent after this one

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
