From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 17:35:51 -0800
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Drivers Updates
 for v4.10
In-Reply-To: <cover.1479389981.git.horms+renesas@verge.net.au>
References: <cover.1479389981.git.horms+renesas@verge.net.au>
Message-ID: <20161119013551.GB2543@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 03:04:35PM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM based SoC drivers updates for v4.10.
> 
> This pull request is based on a merge of:
> 
> * The previous round of such requests, tagged as renesas-drivers-for-v4.10,
>   which you have already pulled.
> * The soc-device-match-tag1 tag of Geert Uytterhoeven's renesas-driver's tree.
>   This is included to provide core soc_device_match() infrastructure which
>   is a dependency of identifying SoC and registering with SoC bus.
> 
> 
> The following changes since commit 437c4eeb0bd4c1d68817be997716f52b8c22a9c3:
> 
>   Merge tag 'soc-device-match-tag1' of https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into HEAD (2016-11-15 14:12:57 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-drivers2-for-v4.10
> 
> for you to fetch changes up to 63ee9e2ba47dbdb42156c9b940515cfd49e78c91:
> 
>   soc: renesas: Identify SoC and register with the SoC bus (2016-11-17 14:37:20 +0100)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM Based SoC Drivers Updates for v4.10
> 
> * Identify SoC and register with the SoC bus
> * Add support for the r8a7745 SoC to rcar-sysc
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (2):
>       ARM: shmobile: Document DT bindings for Product Register
>       soc: renesas: Identify SoC and register with the SoC bus
> 
> Sergei Shtylyov (2):
>       ARM: shmobile: r8a7745: add power domain index macros
>       soc: renesas: rcar-sysc: add R8A7745 support
> 

So, this pull request contains 8 patches, not 4. Seems like your pull
request doesn't show any of the code from Geert's branch, didn't mention
it in the tag and only in the email text above. Furthermore, Geert's
branch modifies driver core code, so it's extra important to make sure
it's clear that it's an unusual pull request.

Given that this modifies driver core, please either merge that code
through Greg first, or get an ack from him. If you merge through him,
make sure it's on a standalone topic branch that we can share.


-Olof
