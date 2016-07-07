From: olof@lixom.net (Olof Johansson)
Date: Wed, 6 Jul 2016 22:30:56 -0700
Subject: [GIT PULL] STi SoC changes for v4.8
In-Reply-To: <57768292.8070901@st.com>
References: <57768292.8070901@st.com>
Message-ID: <20160707053056.GM32389@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 04:47:46PM +0200, Patrice Chotard wrote:
> Hi Olof, Arnd and Kevin,
> 
> Please consider this first round of STi SoC updates for v4.8:
> 
> The following changes since commit 4c2e07c6a29e0129e975727b9f57eede813eea85:
> 
>   Linux 4.7-rc5 (2016-06-26 17:52:03 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git
> sti-soc_for_v4.8

Again, that's a branch and not a tag.

> for you to fetch changes up to 55aa35180c57d82f3db23e5aabce97acb0d36681:
> 
>   ARM: sti: Implement dummy L2 cache's write_sec (2016-07-01 16:23:44 +0200)
> ----------------------------------------------------------------
> 
> Highlights:
> -----------
> _ add a dummy L2 cache's write_sec callback as in non secure mode execution,
>   we can't get access to L2 cache secure registers
> _ cosmetics change, in case of dump_stack, update the hardware name with a
>   more genericfor the STi SoCs family

Minor nit: This is a somewhat odd format to write a list in. Please use
'-' or '*' instead, and feel free to use capital letters, etc. :)


-Olof
