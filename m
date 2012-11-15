From: john.stultz@linaro.org (John Stultz)
Date: Wed, 14 Nov 2012 17:45:31 -0800
Subject: [PATCH v10 0/4] ARM: KDB FIQ debugger
In-Reply-To: <20121016003756.GA23146@lizard>
References: <20121016003756.GA23146@lizard>
Message-ID: <50A4493B.3020207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2012 05:37 PM, Anton Vorontsov wrote:
> Hello Russell,
>
> The KDB/NMI core support has been merged into v3.7-rc1, so the only ARM
> bits are pending now. I believe I addressed all your previous comments,
> but surely there might be something else to improve, thus would be great
> if you could take a look at this.
>
> The patches were rebased onto v3.7-rc1, and this is the only change in
> v10.
>
> Old changelogs and rationale for these patches can be found here:
>
> 	v1-v5, rationale: http://lkml.org/lkml/2012/9/10/2
> 	v6: http://lkml.org/lkml/2012/9/10/2
> 	v7: http://lkml.org/lkml/2012/9/13/367
> 	v8: http://lkml.org/lkml/2012/9/19/525
> 	v9: http://lkml.org/lkml/2012/9/24/538

Just catching up from being on leave, but I've not seen any response to 
this.

Are there objections to this patch set? Or did it just get buried in 
everyone's inbox?

thanks
-john
