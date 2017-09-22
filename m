From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 22 Sep 2017 10:03:59 +0300
Subject: [PATCH] dmaengine: ti-dma-crossbar: Fix possible race condition
 with dma_inuse
In-Reply-To: <20170921173013.GL30097@localhost>
References: <20170921113532.15297-1-peter.ujfalusi@ti.com>
 <20170921173013.GL30097@localhost>
Message-ID: <9ed74f0c-9363-efbf-3fdf-47ebd1fd4eea@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?Vinod,


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 2017-09-21 20:30, Vinod Koul wrote:
> On Thu, Sep 21, 2017 at 02:35:32PM +0300, Peter Ujfalusi wrote:
>> When looking for unused xbar_out lane we should also protect the set_bit()
>> call with the same mutex to protect against concurrent threads picking the
>> same ID.
> 
> Applied, thanks
> 
> Just a note, somehow the patches from you only are getting mangled for me.
> Curiously, the ones in patchworks are fine and I used to apply that, not sure
> what mail servers at our work places are doing!!

I'm afraid it is our mail servers where the mangling is happening :(
We are trying to resolve this since early August when it first started
to happen (and only for the guys in Finland).
We are as frustrated as one can be, believe me.

PS: And the mangler will add a footer on top of this mail

- P?ter
