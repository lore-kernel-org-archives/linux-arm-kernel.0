From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Mar 2016 08:52:28 +0100
Subject: [PATCH 2/2] ARM: dts: sun8i: Orangepi plus gpio keys fixes and
 improvements
In-Reply-To: <1458680002-15021-2-git-send-email-hdegoede@redhat.com>
References: <1458680002-15021-1-git-send-email-hdegoede@redhat.com>
 <1458680002-15021-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20160324075228.GQ30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 09:53:22PM +0100, Hans de Goede wrote:
> Fix the following issues with the gpio_keys node:
> 1) Use of undocumented input-name property
> 2) Use of a unit-address on the sw2 node
> 3) Having "PL03" in the pinctrl node which does not exist, this should
>    be "PL3"
> 
> And add support for the sw2 button on the board.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied both, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160324/30c388c2/attachment.sig>
