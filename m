From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Apr 2012 21:38:40 +0000
Subject: [GIT PULL] ARM: spear-soc support for 3.5
In-Reply-To: <4F8E38B8.20907@st.com>
References: <4F8E38B8.20907@st.com>
Message-ID: <201204222138.40732.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 April 2012, Viresh Kumar wrote:
> Hi Arnd/Olof,
> 
> The following changes since commit a82c81fb238811d4eea6d36b5e0b4c4dda004982:
> 
>   Add linux-next specific files for 20120416 (2012-04-16 16:00:03 +1000)
> 
> are available in the git repository at:
> 
>   git://git.stlinux.com/spear/linux-2.6.git spear-v3.5
> 

Hi Viresh,

I could not pull this tree, because it was based off linux-next rather
than an -rc release. I have instead rebased the commits for you on top of
v3.4-rc3 and split them into a "dt" and a "pinctrl" part that I've applied
to the respective branches in arm-soc.

Please check that everything still works in my version and next time
when you send a pull request do it on top of an -rc release and split
into topics.

	Arnd
