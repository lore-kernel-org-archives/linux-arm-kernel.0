From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Thu, 8 Sep 2011 00:53:31 +0200
Subject: [PATCH 00/14] McBSP cleanup and generalization
In-Reply-To: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
References: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Message-ID: <201109080053.32129.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 Aug 2011 at 17:22:47 Jarkko Nikula wrote:
> Hi
> 
> Updates and continuation to my McBSP cleanup RFC set I sent before
> vacation period. Motivation here is to get rid off all is_omap and
> CONFIG_ARCH stuff and to make code a step more generic (and for
> preparing to move code out under arch/arm/).
> 
> I hope this version doesn't break OMAP1.

Works for me on my Amstrad Delta.

Thanks,
Janusz
