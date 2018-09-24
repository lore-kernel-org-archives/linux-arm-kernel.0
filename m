From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 24 Sep 2018 12:35:08 -0600
Subject: clean up physical merging helpers V2
In-Reply-To: <20180924074355.2802-1-hch@lst.de>
References: <20180924074355.2802-1-hch@lst.de>
Message-ID: <dae7788b-9b0f-bb51-820e-ab626d157e23@kernel.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/24/18 1:43 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series moves various helpers related to merging based on physical
> addresses from the public headers into block/, cleans up the code a bit
> and removes not nessecary includes from the block headers.
> 
> Change since V1:
>  - dropped the Xen related changed which are moved into a new series
>    to be sent after this one

Looks good to me - #1 should just go to the arm guys separately, there's
no point in me carrying this arch patch.

-- 
Jens Axboe
