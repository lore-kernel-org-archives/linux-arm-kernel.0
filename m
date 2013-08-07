From: zonque@gmail.com (Daniel Mack)
Date: Wed, 07 Aug 2013 18:10:55 +0200
Subject: [PATCH 17/20] ASoC: pxa: pxa-pcm-lib: switch over to
 snd-soc-dmaengine-pcm
In-Reply-To: <20130807160743.GI6427@sirena.org.uk>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-18-git-send-email-zonque@gmail.com>
 <20130807160743.GI6427@sirena.org.uk>
Message-ID: <5202718F.2050507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.08.2013 18:07, Mark Brown wrote:
> On Wed, Aug 07, 2013 at 05:34:06PM +0200, Daniel Mack wrote:
>> This patch removes the old PXA DMA API usage and switches over to
>> generic functions provided by snd-soc-dmaengine-pcm.
>>
>> More cleanups may be done on top of this, and some function stubs can
>> now be removed completetly. However, the intention here was to keep
>> the transition as small as possible.
> 
> Has this been tested with the standalone non-ASoC PXA AC'97 driver?

Nope. I have no such device.

It's a real problem for me regarding the entire series. Many drivers are
used in a variaty of runtime configurations, and I can only test a
fraction of them myself of course.

I'd appreciate fix-up patches that I can squash or put on top of mine
from anyone who sees breakage.


Daniel
