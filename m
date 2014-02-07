From: joe@perches.com (Joe Perches)
Date: Thu, 06 Feb 2014 21:11:31 -0800
Subject: [PATCH v5 00/14] Add support for MSM's mmio clock/reset controller
In-Reply-To: <52F45DEE.8020400@gmail.com>
References: <1389811654-21397-1-git-send-email-sboyd@codeaurora.org>
 <52F45DEE.8020400@gmail.com>
Message-ID: <1391749891.15777.31.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-02-06 at 20:15 -0800, Frank Rowand wrote:
> On 1/15/2014 10:47 AM, Stephen Boyd wrote:
> > The first breaks a reset-controller include ordering requirement. It got
> > an ack so I think we're ok for it to go through the clock tree.
> > 
> 
> < snip >
> 
> checkpatch is whining about patches
> 
>   4
>   5
>   6
>   7
>   8
> 
> (Just for completeness if someone thinks I did not check all the patches,
> it also whines about patch 11, but I think the whining should be ignored,
> and it whines about patch 1 but I think that might be a checkpatch bug.)

Hi Frank.

For patch 1, what checkpatch bug might that be?

I think all the checkpatch whinges in patch 11 are correct.

I didn't check any of 4-8.
