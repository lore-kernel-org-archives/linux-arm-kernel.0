From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 25 Nov 2016 11:20:28 +0000
Subject: [RFC PATCH 11/11] ARM: Allow ARCH_MULTIPLATFORM to be selected
 for NOMMU
In-Reply-To: <20161124184532.GI14217@n2100.armlinux.org.uk>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-12-git-send-email-vladimir.murzin@arm.com>
 <16587553.f9R1mxJih5@wuerfel> <583478FB.4020008@arm.com>
 <20161123154829.GA2489@afzalpc>
 <20161123191621.GD14217@n2100.armlinux.org.uk>
 <20161124172535.GA3524@afzalpc>
 <20161124173532.GH14217@n2100.armlinux.org.uk>
 <20161124180751.GA5258@afzalpc>
 <20161124184532.GI14217@n2100.armlinux.org.uk>
Message-ID: <58381E7C.9090000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/11/16 18:45, Russell King - ARM Linux wrote:
> It's this reason that I don't like removing the "depends on MMU" from
> multiplatform - it gives the incorrect impression that we _can_ support
> a wide range of systems, but what it will lead to is a kernel that will
> work on some platforms but not others.  The result will be more "bug"
> reports because the kernel fails to boot...

Do you think extra guarding with CONFIG_EXPERIMENTAL would be appropriate to
reduce number of such reports?

Cheers
Vladimir
