From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 20 Jul 2016 18:22:39 +1000
Subject: [PATCH 2/4] drivers/clocksource/moxart: Refactor enable/disable
In-Reply-To: <20160720081400.GA2705@linaro.org>
References: <1462797169-14512-1-git-send-email-joel@jms.id.au>
 <1462797169-14512-3-git-send-email-joel@jms.id.au>
 <CACPK8XfJ2e1kr-WftidvqsoYew7LqPiNo0sw7opgh8UH=3q_3A@mail.gmail.com>
 <20160510130414.GE14952@linaro.org>
 <CACPK8XdK35p9rxr8et58omvQExjdri20yCq91LGocnPRYpGLQQ@mail.gmail.com>
 <20160720081400.GA2705@linaro.org>
Message-ID: <1469002959.8568.102.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-07-20 at 10:14 +0200, Daniel Lezcano wrote:
> 
> actually I forgot to include your patchset which is no longer applying?
> correctly and the conflicts are not trivials (easy but not trivial). It is a?
> bit late to ask for a last minute pull. Sorry for that.
> 
> Please respin and resend your patchset, I will include it in my tree?
> immediately so that won't happen again. The patch 1/4 is no longer needed.
> 
> If there is a really urgent need of this series, please let us know and?
> Thomas can take a decision accordingly.

I think all the other bits to have basic support for the Aspeed SoC are
in except this one, so it would be nice for this to make the merge
window...

Cheers,
Ben.
