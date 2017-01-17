From: olof@lixom.net (Olof Johansson)
Date: Mon, 16 Jan 2017 22:28:32 -0800
Subject: [GIT PULL] STi DT update for v4.11 round 1
In-Reply-To: <a9026a2a-f5e1-60c3-4e98-0a392d12163d@st.com>
References: <a9026a2a-f5e1-60c3-4e98-0a392d12163d@st.com>
Message-ID: <20170117062832.GK16607@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2017 at 05:59:43PM +0100, Patrice Chotard wrote:
> Hi Arnd, Kevin, Olof
> 
> PLease consider this first round of STi dts update for v4.11 :
> 
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git tags/sti-dt-for-v4.11
> 
> for you to fetch changes up to 2016ead446b98c42dffd9b6c03ce813e5cb3b810:
> 
>   ARM: dts: STiH407-family: Supply Mailbox properties to delta RProc (2017-01-12 17:23:39 +0100)
> 
> ----------------------------------------------------------------
> STi dts update:
> 
> Enable High Quality Video Data Plane (HQVDP) DT entry
> Add DELTA V4L2 video decoder DT entry
> Disable unused fdma instances
> Fix sti-display-subsystem wrong clock parent's value
> Cleanup and update DT entries related to remoteproc

Merged, thanks!


-Olof
