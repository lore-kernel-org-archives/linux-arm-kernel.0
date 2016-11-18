From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 16:43:00 -0800
Subject: [GIT PULL] STi DT fix for v4.9-rcs
In-Reply-To: <3973615b-e1cb-25b3-fff0-201b56162f1a@st.com>
References: <3973615b-e1cb-25b3-fff0-201b56162f1a@st.com>
Message-ID: <20161118004300.GE8578@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 11:38:03AM +0100, Patrice Chotard wrote:
> Hi Arnd, Olof, Kevin
> 
> Please consider this set for inclusion into the v4.9-rc.
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git tags/sti-dt-for-v4.9-rc
> 
> for you to fetch changes up to 5bf7b6e86f29f064979d7b3e6dd21c5dd1feb855:
> 
>   ARM: dts: STiH410-b2260: Fix typo in spi0 chipselect definition (2016-11-15 11:29:25 +0100)
> 
> ----------------------------------------------------------------
> 
> STi DT fix:
> 
> Fix typo cs-gpio to cs-gpios
> 

Hi Patrice,

Merged. Tiny nit for the future: It's nice to see a few words of why a
change is needed/what's broken.  In this case it's pretty obvious from
the code (SPI is broken without it) but it's good habit to motivate
fixes branches in particular.


-Olof
