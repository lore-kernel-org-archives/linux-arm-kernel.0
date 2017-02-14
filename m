From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Tue, 14 Feb 2017 20:21:16 +0100
Subject: [PATCH] ARM: mvebu: add support for the Linksys WRT1900ACS
 (Shelby)
In-Reply-To: <20170214175533.GF25924@io.lakedaemon.net>
References: <20170214085919.3997-1-ralph.sennhauser@gmail.com>
 <20170214175533.GF25924@io.lakedaemon.net>
Message-ID: <20170214202116.035ab193@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Feb 2017 17:55:33 +0000
Jason Cooper <jason@lakedaemon.net> wrote:

> Hi Ralph, Imre,
> 
> On Tue, Feb 14, 2017 at 09:59:17AM +0100, Ralph Sennhauser wrote:
> > The Linksys WRT1900ACS (Shelby) is another Armada 385 based router
> > in the Linksys WRT AC Series which got released in October 2015.
> > 
> > The file armada-385-linksys-shelby.dts is taken from OpenWrt as-is
> > and originally authored by Imre Kaloz.
> > 
> > URL: http://tinyurl.com/j8lz83a  
> 
> Could you please change this to:
> 
> https://github.com/openwrt/openwrt/blob/8466384db1154a107b86bf3ca10b166a21bd81d0/target/linux/mvebu/files/arch/arm/boot/dts/armada-385-linksys-shelby.dts

Is what I had first and thought were to long to pass, so I went with
this one for V2.

Thanks
Ralph

> 
> Or, say 'imported from
> 
>  https://github.com/openwrt/openwrt
> 
> commit 8466384db115 "mvebu: add support for 4.1 and switch over"'
> 
> or something similar?
> 
> Other than that,
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> 
> thx,
> 
> Jason.
