From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 08 Dec 2014 22:49:56 +0100
Subject: [PATCH v5 00/61] dmaengine: Implement generic slave capabilities
 retrieval
In-Reply-To: <20141208183853.GG8739@lukather>
References: <1416231775-31252-1-git-send-email-maxime.ripard@free-electrons.com>
 <20141208061746.GD16827@intel.com> <20141208141807.GC8739@lukather>
 <20141208162843.GP16827@intel.com> <20141208183853.GG8739@lukather>
Message-ID: <54861D04.8000102@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2014 07:38 PM, Maxime Ripard wrote:
[...]
>> And lastly noone blamed you for being late, if things were rosy they
>> would have been merged over the weekend and been in today's next,
>> but...
>
> I totally understand your point. And I actually am a bit uncomfortable
> merging this so late too, and I'd actually prefer to have it merged
> for 3.20. But this is a huge patchset, and I'd really like to avoid
> rebasing it forever.

We don't have to pull in the whole series at once. I think everybody agrees 
that the approach is the right one, so the first couple of patches that work 
on the framework should be good to go in. Same goes for the drivers that 
have been acked and tested.

- Lars
