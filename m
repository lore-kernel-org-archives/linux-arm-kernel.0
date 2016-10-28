From: olof@lixom.net (Olof Johansson)
Date: Thu, 27 Oct 2016 17:05:26 -0700
Subject: [GIT PULL] STi DT update for v4.10 round 1
In-Reply-To: <1a44f1ef-906a-798a-a60b-9d8212209aaa@st.com>
References: <1a44f1ef-906a-798a-a60b-9d8212209aaa@st.com>
Message-ID: <20161028000526.GA7931@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 20, 2016 at 04:27:10PM +0200, Patrice Chotard wrote:
> Hi Arnd, Kevin, Olof
> 
> PLease consider this first round of STi dts update for v4.10 :
> 
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git 

The tag specification fell off. Maybe because it hadn't been mirrored out by
the time you generated the config, since I seem to have found it there
(st-dt-for-4.10).

> 
> for you to fetch changes up to 97a0b97f9e8197429eee5f87ce14373f73dbd9d3:
> 
>   ARM: dts: stih410-clocks: Add PROC_STFE as a critical clock (2016-10-20 16:20:26 +0200)

Merged into next/dt. Thanks!


-Olof
