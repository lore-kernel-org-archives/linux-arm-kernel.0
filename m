From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 20:56:51 -0800
Subject: [GIT PULL] ARM: at91: dt for 4.11 #2
In-Reply-To: <20170126162754.rn2kj6ecser5tzyq@piout.net>
References: <20170126162754.rn2kj6ecser5tzyq@piout.net>
Message-ID: <20170130045651.GC18943@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 05:27:54PM +0100, Alexandre Belloni wrote:
> Hi,
> 
> Two non urgent fixes for 4.11 that could hopefully be backported as far
> back as possible to make kernelci (and our users) happy.
> 
> The following changes since commit 21dd0ece34c2a07432a1cd0bbcb4815ce2b49173:
> 
>   ARM: dts: at91: add devicetree for the Axentia TSE-850 (2017-01-10 16:16:33 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.11-dt2
> 
> for you to fetch changes up to 78162d48466d23c45a784034630c5928af631e3d:
> 
>   ARM: dts: at91: Enable DMA on sama5d2_xplained console (2017-01-23 00:33:43 +0100)
> 
> ----------------------------------------------------------------
> DT for 4.11 #2:
> 
>  - Enable the DMA on sama5d2 and sama5d4 xplained to fix an issue seen by
>  kernelci

Merged, thanks!


-Olof
