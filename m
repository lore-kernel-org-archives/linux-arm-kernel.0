From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Apr 2016 12:16:45 -0700
Subject: [GIT PULL] Renesas ARM Based SoC Cleanup for v4.7
In-Reply-To: <cover.1459731908.git.horms+renesas@verge.net.au>
References: <cover.1459731908.git.horms+renesas@verge.net.au>
Message-ID: <20160413191645.GO19945@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 10:22:33AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC cleanup for v4.7.
> 
> 
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-for-v4.7
> 
> for you to fetch changes up to 000025cfbb9e8bafd0a1fa84d8d83526d24bde42:
> 
>   ARM: dts: sh73a0: Remove unnecessary clock-output-names properties (2016-03-28 08:56:11 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Cleanup for v4.7
> 
> * Remove unnecessary clock-output-names properties from DT
> * Use generic pinctrl properties in DT

Hi,

Ok, so this is the second cleanup-labelled branch from you. I'm OK with these
being split out, but we normally don't merge dt changes in the cleanup branch,
we group them with other DT changes. So I've merged this into next/dt.

If you want to separate out dt cleanups, I'm OK with that. Just don't mix
DT and non-DT cleanups in those branches in the future, so I can still choose
to merge into next/dt.


-Olof
