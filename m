From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Oct 2012 18:37:03 +0000
Subject: [RFC PATCHv2] ARM: vt8500: Convert arch-vt8500 to multiplatform
In-Reply-To: <20121016181758.GA1801@quad.lixom.net>
References: <1349942353-14972-1-git-send-email-linux@prisktech.co.nz>
 <20121016181758.GA1801@quad.lixom.net>
Message-ID: <201210161837.03651.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 October 2012, Olof Johansson wrote:
> On Thu, Oct 11, 2012 at 08:59:13PM +1300, Tony Prisk wrote:
> > This patch completes the conversion to ARCH_MULTI_V5 for arch-vt8500.
> > Removed /mach/include/ and remaining unneeded files.
> > 
> > Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> 
> Acked-by: Olof Johansson <olof@lixom.net>
> 
> I think it's time to add a defconfig for vt8500 so we get build coverage. Can
> you please do so for 3.8, maybe as a part of the branch this patch goes in?

Wouldn't this just be part of a new multi_v5_defconfig?

I don't object to having a vt8500-only defconfig, but I think we should
also enable it in the normal one.

	Arnd
