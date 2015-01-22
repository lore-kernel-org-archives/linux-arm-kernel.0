From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Jan 2015 17:33:01 -0800
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC Updates for v3.20
In-Reply-To: <cover.1421715134.git.horms+renesas@verge.net.au>
References: <cover.1421715134.git.horms+renesas@verge.net.au>
Message-ID: <20150122013301.GC31815@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 10:27:08AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these third round of Renesas ARM based SoC updates for v3.20.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-soc2-for-v3.20,
> which I have already sent a pull-request for.
> 
> 
> The following changes since commit 2173fc7cb681c38b9e5bc526211045caecf96e44:
> 
>   ARM: shmobile: R-Mobile: Add DT support for PM domains (2015-01-15 08:38:14 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc3-for-v3.20
> 
> for you to fetch changes up to 1632ff162f305f38667632c465e4bfaab8ef87a2:
> 
>   ARM: shmobile: R-Mobile: Special-case PM domains with memory-controllers (2015-01-16 11:02:42 +0900)

Simon,

Doing each merge of a pull request is an amount of work from us. You sent
a preceding pull request for the soc branch just three days before this one.

Can you try to reduce the frequency of how often you drain the queue
of pending patches, perhaps? I know there's a balance to be had between
merge early-merge often and getting more aggregated, but I wonder if it
can be tuned back a bit to avoid flooding us.

Maybe a good balance would be wait to send the next pull request of a
branch until the previous one has been taken care of.

That being said: Merged.


Thanks,

-Olof
