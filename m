From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Jan 2015 14:44:17 -0800
Subject: [GIT PULL] Renesas ARM Based SoC Drivers Updates for v3.20
In-Reply-To: <cover.1421371868.git.horms+renesas@verge.net.au>
References: <cover.1421371868.git.horms+renesas@verge.net.au>
Message-ID: <20150121224417.GD24851@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 11:35:06AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC drivers updates for v3.20.
> 
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-drivers-for-v3.20

Simon,

Your emails are somewhat confusing, in that you have to: a handful of people
individually, but not arm at kernel.org. It's clearer that you want us to merge
this pull request if you do to: arm at kernel.org and keep the FYI recipients on
cc.


Now, about this branch: There's not a single review by anyone on the
drivers/bus pieces, nor on the binding. Please collect some, especially since
simple-bus is used by so many.


-Olof
