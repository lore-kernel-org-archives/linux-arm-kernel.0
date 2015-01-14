From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 14 Jan 2015 18:49:15 +0100
Subject: [PATCH v4] Added support for pogoplug e02 (pink/gray)
In-Reply-To: <1421210969-12446-1-git-send-email-ottxor@gentoo.org>
References: <CAA8MNVjieDJ-dv2NNWXK=+uqrPmvtk2EiBYJGJkMugEiN2TsAw@mail.gmail.com>
 <1421210969-12446-1-git-send-email-ottxor@gentoo.org>
Message-ID: <20150114174915.GA389@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 09:49:29PM -0700, Christoph Junghans wrote:
> The pogoplug differs from the SheevaPlug only by a
> few details, but especially in the led assignments.
> This patch was tested under Gentoo Linux and is
> based on dts files from Arch Linux ARM and OpenWrt.
> 
> Suggested-by: Felix Kaechele <heffer@fedoraproject.org>
> Suggested-by: Oleg Rakhmanov <moonman.ca@gmail.com>
> Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
> ---
> 
> V1: initial patch
> V2: added GPL-2 header
>     dropped earlyprintk from bootargs
>     added stdout-path
>     change leds name to scheme "devicename:colour:function"
> V3: rebase on v3.19-rc4
>     fixed stdout-path to be &uart0
>     fixed compiling issue by using pin-controller
> V4: moved ocp at f1000000 block into &uart and &pinctrl

Hi Christoph

Thanks for these last changes. It looks good now, and i've added it to
mvebu/dt. So long as there are no more comments, i will pass it
upstream soon.

Thanks
        Andrew
