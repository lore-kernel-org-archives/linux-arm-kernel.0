From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2018 15:59:31 +0100
Subject: [GIT PULL] STi DT update for v4.17 round 2
In-Reply-To: <af473935-7cb6-e59a-3b52-055d8492248c@st.com>
References: <af473935-7cb6-e59a-3b52-055d8492248c@st.com>
Message-ID: <CAK8P3a1R6CwHC4+0GXKevmgM9QqgbGGZCtLsccn2AYTpuHZ7uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 10:06 AM, Patrice CHOTARD
<patrice.chotard@st.com> wrote:
> Hi Arnd, Kevin, Olof
>
> PLease consider this second round of STi dts update for v4.17
>
> The following changes since commit 0e04ce02e6a2ac30d21294d8bb2aeceb8489e52b:
>
>    ARM: dts: STi: Remove unused clk_ext2f_a9 clock (2018-02-13 13:31:38
> +0100)
>
> are available in the git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git
>
> for you to fetch changes up to 9a5f4879cd8de167e82f335317c63f2ffdc80129:
>
>    ARM: dts: stih4xx: Add missing #sound-dai-cells (2018-03-15 09:52:25
> +0100)
>
> ----------------------------------------------------------------
>
> STi DT update:
>
> Add missing #sound-dai-cells which fix DT dtc warnings when building
> with W=1

You missed a tag name for this one, but I found tags/sti-dt-for-v4.17-round2
to be the one that matches the commit ID above and pulled that.

      Arnd
