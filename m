From: zonque@gmail.com (Daniel Mack)
Date: Thu, 08 Aug 2013 11:03:44 +0200
Subject: [PATCH 17/20] ASoC: pxa: pxa-pcm-lib: switch over to
 snd-soc-dmaengine-pcm
In-Reply-To: <52035A81.6090903@metafoo.de>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-18-git-send-email-zonque@gmail.com>
 <20130807160743.GI6427@sirena.org.uk> <5202718F.2050507@gmail.com>
 <20130807163258.GL6427@sirena.org.uk> <52035463.1030909@gmail.com>
 <52035A81.6090903@metafoo.de>
Message-ID: <52035EF0.1030208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.08.2013 10:44, Lars-Peter Clausen wrote:
> On 08/08/2013 10:18 AM, Daniel Mack wrote:

>> I guess we have two options: either duplicate code from
>> soc-dmaengine-pcm, or move soc-dmaengine-pcm out of the ASoC context. I
>> actually see no dependecy to ASoC from there anyway.
> 
> There is intentionally no dependency on ASoC for the soc-dmaengine-pcm code, 
> though since I wasn't sure whether there was ever going to be a userside 
> outside of ASoC the coded ended up in ASoC folder. It shouldn't be a problem to 
> make it available to all of ALSA.

Ok, great. I queued a patch for that. Will be part of my next spin, or,
in case the series doesn't make it in time, I'll re-post all the patches
that can be applied independently up front.


Thanks,
Daniel
