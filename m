From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Nov 2014 17:49:30 +0100
Subject: [PATCH 1/7] ARM: dts: sunxi: Add regulator-boot-on property to
 ahci-5v regulator
In-Reply-To: <1415871109-28332-1-git-send-email-hdegoede@redhat.com>
References: <1415871109-28332-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20141113164930.GP20972@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 10:31:43AM +0100, Hans de Goede wrote:
> This avoids it getting briefly turned off between when the regulator getting
> registered and the ahci driver turning it back on, thus avoiding the disk
> going into emergency head park mode.
> 
> Cc: Bruno Pr?mont <bonbons@linux-vserver.org>
> Reported-and-tested-by: Bruno Pr?mont <bonbons@linux-vserver.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, and split up the tags.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/69844dc4/attachment-0001.sig>
