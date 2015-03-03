From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 3 Mar 2015 10:57:59 +0100
Subject: [PATCH v4 2/2] ARM: mvebu: a385-db-ap: Enable the NAND
In-Reply-To: <54F56C67.7070404@free-electrons.com>
References: <1424255528-1717-1-git-send-email-maxime.ripard@free-electrons.com>
 <1424255528-1717-3-git-send-email-maxime.ripard@free-electrons.com>
 <54F56C67.7070404@free-electrons.com>
Message-ID: <20150303095759.GE4911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 09:10:15AM +0100, Gregory CLEMENT wrote:
> Hi Maxime,
> 
> On 18/02/2015 11:32, Maxime Ripard wrote:
> > The Armada 385 Access Point Development Board has a 1GB NAND SLC chip from
> > Micron as its main storage. Enable it.
> 
> I wanted applying your patch but it failed. Actually it depends on your
> other patch "ARM: mvebu: armada-385-ap: Enable USB3 port" and this patch
> depend on an other patch "usb: xhci: plat: Add USB phy support" which
> hadn't been merged.

Hmmmm, indeed.

> So either you send a new version which apply on 4.0-rc1, or we can wait for
> that "usb: xhci: plat: Add USB phy support" will be merged then I will be able
> applying "ARM: mvebu: armada-385-ap: Enable USB3 port" and finally this patch.
> As you want.

I'll send a new version.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150303/dce0daea/attachment.sig>
