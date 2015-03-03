From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 3 Mar 2015 10:59:24 +0100
Subject: [PATCH v2 3/3] ARM: mvebu: armada-385-ap: Enable USB3 port
In-Reply-To: <54F4B8B9.4010204@free-electrons.com>
References: <1421672474-2945-1-git-send-email-maxime.ripard@free-electrons.com>
 <1421672474-2945-4-git-send-email-maxime.ripard@free-electrons.com>
 <54F4B8B9.4010204@free-electrons.com>
Message-ID: <20150303095924.GF4911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 08:23:37PM +0100, Gregory CLEMENT wrote:
> Hi Maxime,
> 
> On 19/01/2015 14:01, Maxime Ripard wrote:
> > The Armada 385 AP board has a USB3 port exposed that uses a GPIO to drive the
> > VBUS line. Enable the needed drivers to support this.
> > 
> 
> it seems that this patch was not applied yet. Patch 1 is now in
> linux-next and should be part of 4.0-rc. But what about patch 2?

IIRC, Greg or Matthias said that Matthias would look into these
patches after the merge window.

It still didn't happen though.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150303/662951ce/attachment.sig>
