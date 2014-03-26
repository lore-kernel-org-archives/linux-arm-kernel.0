From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 26 Mar 2014 10:39:46 +0100
Subject: [PATCH v7 2/3] ARM: sun7i/sun6i: dts: Add NMI irqchip support
In-Reply-To: <53329243.8090604@redhat.com>
References: <1395256879-8475-1-git-send-email-carlo@caione.org>
 <1395256879-8475-3-git-send-email-carlo@caione.org>
 <53329243.8090604@redhat.com>
Message-ID: <20140326093946.GE6120@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 09:39:31AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 03/19/2014 08:21 PM, Carlo Caione wrote:
> > This patch adds DTS entries for NMI controller as child of GIC.
> > 
> > Signed-off-by: Carlo Caione <carlo@caione.org>
> 
> Note this breaks the kernel on sun6i / A31 since we don't have a
> pmic driver there yet, and thus the nmi gets constantly fired without
> anything clearing it.
> 
> So the sun6i section needs a status = "disabled"; until we actually have pmic
> support.

I guess it also applies to the A20, since the PMIC patches will
probably get merged later on?

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140326/27964565/attachment.sig>
