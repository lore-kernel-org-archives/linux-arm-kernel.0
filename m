From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 May 2014 23:23:32 -0700
Subject: [GIT PULL] ARM: STi: DT changes for v3.16
In-Reply-To: <537A1E9F.2010804@st.com>
References: <537A1E9F.2010804@st.com>
Message-ID: <20140520062332.GV18956@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 19, 2014 at 05:09:19PM +0200, Maxime Coquelin wrote:
> Hi Olof, Kevin and Arnd,
> 
> Please consider these STi DT updates for v3.16.
> 
> This is now based on v3.15-rc1.
> 
> Note that two reset patches are part of this pull request, in order to avoid
> compilation breakage.
> Adding these two patches in this pull request has been accepted by Philipp Zabel.
> 
> 
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
> 
>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
> 
> are available in the git repository at:
> 
>   git://git.stlinux.com/devel/kernel/linux-sti.git tags/sti-dt-for-v3.16
> 
> for you to fetch changes up to c3037f761ff57b8a85cd41bbe995af78af064e33:
> 
>   ARM: STi: DT: STiH41x Add clk_ignore_unused to bootargs (2014-05-17 10:19:09 +0200)

I found a few issues when I looked at this branch, and replied to a
couple of the patches. What particularly bothers me is the style you're
implementing your DTSI/DTS files in, with odd naming and all-caps stuff
for clocks. Please revisit -- I would prefer to see a set of cleanup
patches that fixes the existing platforms to switch to a sane scheme
before you add new SoC support on top.


-Olof
