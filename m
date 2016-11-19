From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 17:41:50 -0800
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates
 for v4.10
In-Reply-To: <cover.1479388193.git.horms+renesas@verge.net.au>
References: <cover.1479388193.git.horms+renesas@verge.net.au>
Message-ID: <20161119014150.GC2543@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 03:04:55PM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM64 based SoC DT updates
> for v4.10.
> 
> This pull request is based on a merge of:
> 
> * The previous round of such requests, tagged as renesas-arm64-dt-for-v4.10,
>   which I have already sent a pull-request for.
> * The "Second Round of Renesas ARM Based SoC Drivers Updates for v4.10",
>   tagged as renesas-drivers2-for-v4.10, which I have also sent a pull
>   request for. This is included to provide dependencies for adding device
>   nodes for PRR.

Please avoid entangling these pull requests, since now I can't merge DT since
I'm rejecting your drivers pull request.

I also don't understand why you need a driver branch as base. The PRR
nodes are literally just a compatible field and a reg entry. It should
depend on nothing.

So, I'm a little confused here. Please disentangle this and send a separate
pull request, I'll be happy to merge that.


-Olof
