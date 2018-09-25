From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Sep 2018 22:09:58 +0200
Subject: clean up physical merging helpers V2
In-Reply-To: <dae7788b-9b0f-bb51-820e-ab626d157e23@kernel.dk>
References: <20180924074355.2802-1-hch@lst.de>
 <dae7788b-9b0f-bb51-820e-ab626d157e23@kernel.dk>
Message-ID: <20180925200958.GA8413@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2018 at 12:35:08PM -0600, Jens Axboe wrote:
> Looks good to me - #1 should just go to the arm guys separately, there's
> no point in me carrying this arch patch.

It would require a respin of all the Xen patches and is rather related.
But if you absolutely don't want it I can drop it from the resend of
those.
