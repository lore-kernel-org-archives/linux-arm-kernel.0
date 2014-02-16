From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 16 Feb 2014 19:43:43 +0100
Subject: [PATCH] arm: imx: remove MACH_MXLADS
In-Reply-To: <1392574562.956803244@f244.i.mail.ru>
References: <1392573811.28866.22.camel@x220>
 <1392574562.956803244@f244.i.mail.ru>
Message-ID: <1392576223.28866.24.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2014-02-16 at 22:16 +0400, Alexander Shiyan wrote:
> ???????????, 16 ??????? 2014, 19:03 +01:00 ?? Paul Bolle <pebolle@tiscali.nl>:
> > The Kconfig symbol MACH_MXLADS was added in v2.6.29. It has never been
> > used. Setting it has no effect. There are no calls for
> > machine_is_mxlads(). This symbol can safely be removed.
> > 
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> 
> This is used by mach-mx1ads.c

How is it used?


Paul Bolle
