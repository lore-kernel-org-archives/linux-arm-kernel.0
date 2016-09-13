From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Sep 2016 17:27:32 +0200
Subject: [GIT PULL] STi DT updates for v4.9
In-Reply-To: <c83fda3c-5120-a55b-dfb0-f550cbaf777a@st.com>
References: <c83fda3c-5120-a55b-dfb0-f550cbaf777a@st.com>
Message-ID: <4599921.Xv3Qd3jgsj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 2, 2016 3:58:00 PM CEST Patrice Chotard wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git
> 
> for you to fetch changes up to ba5ba11906d5462993f5fd4e3da4d234505427a0:
> 
>   ARM: dts: STiH41x-b2020: Update gpio specifier (2016-09-02 15:15:14 +0200)
> 
> ----------------------------------------------------------------
> 
> STi dts fixes and new STi 96board support:
> 
> Add thermal node for STiH407 family boards
> Add specific nodes for STMicroelectronics 96Board
> Add new B2260 STi board file = 96Board
> Fix ahci issue on STiH407 family
> Fix debugfs/pinctrl kernel warning
> Update gpio-cells and gpio specifier
> 

Pulled into next/dt. The URL had no tag name, but I found the tag "sti-dt-for-v4.9-1"
in your tree with that commit ID, so I pulled that.
    
Not sure what went wrong on your end, it wasn't a big deal but please
try to always include the tag. Thanks!

	Arnd
