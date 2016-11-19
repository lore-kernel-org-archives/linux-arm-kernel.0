From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 17:28:36 -0800
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Updates for v4.10
In-Reply-To: <cover.1479387356.git.horms+renesas@verge.net.au>
References: <cover.1479387356.git.horms+renesas@verge.net.au>
Message-ID: <20161119012836.GA2543@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 02:34:25PM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM based SoC updates for v4.10.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-soc-for-v4.10,
> which I have already sent a pull-request for.
> 
> 
> The following changes since commit 9652623f8f019edc93a7a934a10b7d0b90421d5a:
> 
>   ARM: shmobile: r8a7779/marzen: Add board part number to DT bindings (2016-11-04 10:25:45 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v4.10
> 
> for you to fetch changes up to 4af239175d00c1866cc6b41f3eabcf93c45dcc40:
> 
>   ARM: shmobile: document SK-RZG1E board (2016-11-15 10:59:35 +0100)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM Based SoC Updates for v4.10
> 
> * Basic support for r8a7745 SoC
> 
> ----------------------------------------------------------------
> Sergei Shtylyov (2):
>       ARM: shmobile: r8a7745: basic SoC support
>       ARM: shmobile: document SK-RZG1E board

Hi,

Is there a reason you're adding a config option per SoC?

I think you'd be better off not adding these config options, and just adding
support for the SoCs through compatibles (and adding the drivers to defconfigs,
etc).

Anyway, I've merged this branch since this is along the lines of what you
already have, but it could be worth looking at cleaning up and removing
some of these options.


-Olof
