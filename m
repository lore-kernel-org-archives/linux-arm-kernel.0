From: olof@lixom.net (Olof Johansson)
Date: Sun, 27 Jan 2013 21:53:04 -0800
Subject: [GIT PULL V2 2/4] ARM: mvebu: drivers for v3.9
In-Reply-To: <1358909285.ca5b742.21555@triton>
References: <pull-1358909291-876385>
 <1358909285.ca5b742.21555@triton>
Message-ID: <20130128055304.GA25723@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 02:48:05AM +0000, Jason Cooper wrote:
> The following changes since commit 4b53ab9cb853e446f628e561ce6fcc527df30a76:
> 
>   Merge branch 'mvebu/fixes' into mvebu/drivers (2013-01-23 01:42:14 +0000)
> 
> are available in the git repository at:
> 
> 
>   git://git.infradead.org/users/jcooper/linux.git tags/drivers_for_v3.9
> 
> for you to fetch changes up to 43076a4c4e5fb92721bedc5d05b93468d6d76b2c:
> 
>   mmc: mvsdio: add pinctrl integration (2013-01-23 01:42:29 +0000)
> 
> ----------------------------------------------------------------
> mvebu drivers for v3.9
>  - mvsdio
>    - use slot-gpio for card detect and write protect
>    - add DT binding
>    - add pinctrl integration
>  - use rtc-mv in mvebu armv7 SoCs
>  - add pci-e hotplug for kirkwood

Hi,

I didn't see any acks by Chris Ball on these, he's usually pretty
responsive on code reviews so I just wanted to make sure he's OK with
us taking this through arm-soc, and aware of it.

Looks like this whole branch could go through the mmc tree? The dtsi
updates from the last branch would still go through arm-soc.

Either way is fine with me, I just don't want to make life difficult for Chris
in case he has some sweeping changes planned that might cause conflicts, etc.


-Olof
