From: zonque@gmail.com (Daniel Mack)
Date: Fri, 09 Aug 2013 15:03:47 +0200
Subject: [PATCH 13/20] ASoC: pxa: pxa-ssp: add DT bindings
In-Reply-To: <20130808132000.GD6427@sirena.org.uk>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-14-git-send-email-zonque@gmail.com>
 <20130807164039.GM6427@sirena.org.uk> <5203676F.6090708@gmail.com>
 <20130808132000.GD6427@sirena.org.uk>
Message-ID: <5204E8B3.5060605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.08.2013 15:20, Mark Brown wrote:
> On Thu, Aug 08, 2013 at 11:39:59AM +0200, Daniel Mack wrote:
> 
>> Then, we should also allocate the DMA channel from the upstream device
>> and pass it down to the DAI. But then again, the pxa-pcm-lib needs some
>> rework, as it's currently in charge of obtaining and releasing the channel.
> 
>> I wanted to postpone that issue until the rest of the series has settled
>> and limit changes to the bare minimum for now. Does that sound feasible?
> 
> Yup, the big problem here is the whole DT as ABI thing - what happens in
> the code isn't so important but the DT is supposed to be stable.  Or we
> could decide that this is one of the cases that's unstable in which case
> we should probably flag it up in the DT binding document if nothing else.
> 

Alright, I agreee. It's not much code that was needed to add support for
what I proposed, so I added a patch for that to my queue. Thanks for the
heads-up.


Daniel
