From: kaloz@openwrt.org (Imre Kaloz)
Date: Thu, 24 May 2012 11:31:41 +0200
Subject: [PATCH] ixp4xx: fix compilation by adding gpiolib support
In-Reply-To: <201205231939.49681.arnd@arndb.de>
References: <1337789991-5283-1-git-send-email-richardcochran@gmail.com>
 <201205231743.50262.arnd@arndb.de> <87396qbtrx.fsf@lebrac.rtp-net.org>
 <201205231939.49681.arnd@arndb.de>
Message-ID: <op.wes3e3w72s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 May 2012 21:39:49 +0200, Arnd Bergmann <arnd@arndb.de> wrote:

<snip>

> Ok, thanks for the info. I'm sorry that it has come so far. I think Olof
> and I are generally doing a good job at picking up all the pull requests,
> but we sometimes miss single patches, especially when it's not clear that
> they are expected to go into the arm-soc tree.
>
> I have to admit that I didn't even remember who maintains ixp4xx, since
> there hasn't been a single ixp4xx patch from Imre or Krzysztof that I've  
> put
> into the kernel over this time frame.

The gpiolib patch originated from me as well.

> I've put the patch into the fixes branch now, it should be part of
> the next round of submissions.

Thanks.

> What is the plan for ixp4xx going forward? Is one of you planning to
> maintain a git tree and collect patches for inclusion in arm-soc?
> I would be more comfortable just knowing where to pull from than
> having to watch the mailing list and making sure the maintainers
> Ack all the patches.
>
> If there is no tree, should we downgrade ixp4xx in the MAINTAINERS
> file from "Maintained" to "Odd fixes"?

Quite some patches are still in the OpenWrt repo only. When I'll have  
time, I'll revisit those as well as migrate ixp4xx to DT. I'm overloaded  
with work, so I'll need a few more weeks and I guess the same is true for  
Krzysztof as well..


Imre
