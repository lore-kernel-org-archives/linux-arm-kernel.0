From: filip.zyzniewski@gmail.com (Filip Zyzniewski)
Date: Sat, 26 Dec 2009 16:55:20 +0100
Subject: DMA/cache problems on SA1110/SA1111 (Was: Re: USB Host on a
	SA1111)
In-Reply-To: <de2dcbb80912260618w3d3978c9pc8362ce9f2458459@mail.gmail.com>
References: <de2dcbb80912220833mdc1788cq6f60dd5522e7ab0@mail.gmail.com>
	<20091222165904.GE17191@n2100.arm.linux.org.uk>
	<de2dcbb80912260618w3d3978c9pc8362ce9f2458459@mail.gmail.com>
Message-ID: <de2dcbb80912260755o3af8db8fjf812525cf2dc23ad@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 26, 2009 at 3:18 PM, Filip Zyzniewski
<filip.zyzniewski@gmail.com> wrote:
>
> Should I try to port the remaining part of the 2.4 function to the 2.6 one?

I have noticed that dma masks setup includes these limitations in
arch/arm/common/sa1111.c:525 and 527, so I think there is no need for
porting that, I'll try to find some other possible cause of my
problems.

regards,
Filip Zyzniewski
