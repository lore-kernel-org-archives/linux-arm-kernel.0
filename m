From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 25 Sep 2018 14:25:28 -0600
Subject: clean up physical merging helpers V2
In-Reply-To: <20180925200958.GA8413@lst.de>
References: <20180924074355.2802-1-hch@lst.de>
 <dae7788b-9b0f-bb51-820e-ab626d157e23@kernel.dk>
 <20180925200958.GA8413@lst.de>
Message-ID: <88a1a096-b35d-dce1-3e19-0601a4c312eb@kernel.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/25/18 2:09 PM, Christoph Hellwig wrote:
> On Mon, Sep 24, 2018 at 12:35:08PM -0600, Jens Axboe wrote:
>> Looks good to me - #1 should just go to the arm guys separately, there's
>> no point in me carrying this arch patch.
> 
> It would require a respin of all the Xen patches and is rather related.
> But if you absolutely don't want it I can drop it from the resend of
> those.

I don't feel that strongly about it, and it's dead block code. If it makes
your life easier, I can add it.

-- 
Jens Axboe
