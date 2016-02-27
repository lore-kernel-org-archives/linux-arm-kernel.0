From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Sat, 27 Feb 2016 16:03:04 +0100
Subject: [PATCH 0/7] arm/arm64: Alpine patches for 4.6
In-Reply-To: <2955978.E8qlghcpm8@wuerfel>
References: <1456395297-6505-1-git-send-email-antoine.tenart@free-electrons.com>
 <2955978.E8qlghcpm8@wuerfel>
Message-ID: <20160227150304.GF12453@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Fri, Feb 26, 2016 at 11:02:21PM +0100, Arnd Bergmann wrote:
> On Thursday 25 February 2016 11:14:50 Antoine Tenart wrote:
> > 
> > Here are the Alpine patches for 4.6. As seen with Olof these patches are
> > sent to you as a series as there are only 7 of them. I'll get my gpg key
> > signed and setup a git tree somewhere for next time.
> > 
> > The first 3 patches introduce a basic arm64 Alpine support, by adding
> > the Alpine v2 EVP board. The last 4 patches add an MSIX node in both
> > Alpine v1 (arm) and Alpine v2 (arm64) dtsi and select the Alpine MSI
> > controller driver.
> 
> Applied the patches to the next/dt, next/dt64, next/arm64 and next/soc
> branches, respectively. I did not see any strong dependencies between
> the patches, so they are now out of order (depending how Linus
> pulls our branches). Please check if that's ok and if I missed anything.

You're right, there are no strong dependencies between the patches.

Thanks!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160227/1905af9b/attachment.sig>
