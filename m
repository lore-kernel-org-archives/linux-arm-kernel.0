From: zhiyong.tao@mediatek.com (Zhiyong Tao)
Date: Thu, 21 Sep 2017 16:13:12 +0800
Subject: [PATCH 2/3] arm64: dts: mt2712: add pintcrl device node.
In-Reply-To: <CACRpkdZHyXec+L8ueRHOs=9TLT1Arqe3KeQpRZ6D0K1Ag1c+Zw@mail.gmail.com>
References: <1501489333-23145-1-git-send-email-zhiyong.tao@mediatek.com>
 <1501489333-23145-3-git-send-email-zhiyong.tao@mediatek.com>
 <2f883a8a-5402-5625-bada-bcfed53c098e@gmail.com>
 <CACRpkdZHyXec+L8ueRHOs=9TLT1Arqe3KeQpRZ6D0K1Ag1c+Zw@mail.gmail.com>
Message-ID: <1505981592.22452.7.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-08-22 at 15:04 +0200, Linus Walleij wrote:
> On Mon, Aug 14, 2017 at 5:23 PM, Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
> > On 07/31/2017 10:22 AM, Zhiyong Tao wrote:
> >>
> >> The commit includes two change:
> >> 1)add pintcrl device node for mt2712.
> >> 2)add pinfunc file for mt2712.
> >>
> >> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> >> ---
> >>   arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h | 1014
> >> +++++++++++++++++++++++++
> >
> >
> > Shouldn't this file be in include/dt-bindings/pinctrl?
> 
> Only if it is also #included in the driver.
> 
> Yours,
> Linus Walleij

==>
Thanks for your comment. 
We see our some ICs(mt7623) which move the file to
"include/dt-bindings/pinctrl". other ICs(mt2701) which is put in
"arch/arm64/boot/dts/mediatek".
In mt2712, mt2712-pinfunc.h is only include by dts file. It won't be
included by driver. So which is better? "arch/arm64/boot/dts/mediatek/"
or "include/dt-bindings/pinctrl".

Thanks.
