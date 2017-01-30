From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 21:00:59 -0800
Subject: [GIT PULL] STi DT fix for v4.10-rcs???
In-Reply-To: <fec421f0-7515-c80d-3b36-969d63758a8b@st.com>
References: <fec421f0-7515-c80d-3b36-969d63758a8b@st.com>
Message-ID: <20170130050059.GI18943@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 04:10:10PM +0000, Patrice CHOTARD wrote:
> Hi Arnd, Olof, Kevin
> 
> Please consider this set for inclusion into the next v4.10-rc.
> 
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>    Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git 
> tags/sti-dt-for-v4.10-rc
> 
> for you to fetch changes up to 8413299cb3933dade6186bbee8363f190032107e:
> 
>    ARM: dts: STiH407-family: set snps,dis_u3_susphy_quirk (2017-01-27 
> 16:17:13 +0100)
> 
> ----------------------------------------------------------------
> 
> STi DT fix:
> 
> Since v4.10-rc1, xhci is complaining in loop with :
> [ 801.953836] usb usb6-port1: Cannot enable. Maybe the USB cable is bad?
> [ 801.960455] xhci-hcd xhci-hcd.0.auto: Cannot set link state.
> [ 801.966611] usb usb6-port1: cannot disable (err = -32)
> 
> Set property "snps,dis_u3_susphy_quirk" in DT fix it.
> 
> ----------------------------------------------------------------
> Patrice Chotard (1):
>        ARM: dts: STiH407-family: set snps,dis_u3_susphy_quirk

Merged, thanks.


-Olof
