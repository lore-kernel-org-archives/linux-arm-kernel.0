From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 13:21:36 -0500 (EST)
Subject: [PATCH 20/20] ARM: big removal of now unused arch_reset()
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F3E9977B55@AUSP01VMBX24.collaborationhost.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
 <1324288069-21940-21-git-send-email-nico@fluxnic.net>
 <ADE657CA350FB648AAC2C43247A983F001F3E9977B55@AUSP01VMBX24.collaborationhost.net>
Message-ID: <alpine.LFD.2.02.1112191320350.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Dec 2011, H Hartley Sweeten wrote:

> On Monday, December 19, 2011 2:48 AM, Nicolas Pitre wrote:
> > diff --git a/arch/arm/mach-ep93xx/include/mach/system.h b/arch/arm/mach-ep93xx/include/mach/system.h
> > deleted file mode 100644
> > index b5bec7cb9b..0000000000
> > --- a/arch/arm/mach-ep93xx/include/mach/system.h
> > +++ /dev/null
> > @@ -1,7 +0,0 @@
> > -/*
> > - * arch/arm/mach-ep93xx/include/mach/system.h
> > - */
> > -static inline void arch_idle(void)
> > -{
> > -	cpu_do_idle();
> > -}
> 
> For this part and [PATCH 19/20], for ep93xx...
> 
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Thanks


Nicolas
