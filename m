From: olof@lixom.net (Olof Johansson)
Date: Wed, 14 Aug 2013 01:21:38 -0700
Subject: [GIT 00/14] Second round of Renesas ARM based SoC cleanups for
 v3.12
In-Reply-To: <cover.1375344714.git.horms+renesas@verge.net.au>
References: <cover.1375344714.git.horms+renesas@verge.net.au>
Message-ID: <20130814082138.GA516@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 05:26:14PM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> Please consider this second round of Renesas ARM based SoC cleanups for
> v3.12.
> 
> This pull-request is based on a merge of renesas-tpu-pwm-for-v3.12,
> renesas-backlight-for-v3.12 and renesas-soc-for-v3.12, each of which
> I have previously sent a pull-request for, in order to provide
> the pre-requisite code that that is being removed or cleaned up.

Hm, I'm a little sad to see the added circular dependency here. It would have
been very nice if the patches could be organized such that it would have been
avoided.

I'll probably pull this in as a new next/* branch, but if you can avoid these
next release cycle without it complicating things too much that'd be awesome.


-Olof
