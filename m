From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 10 Sep 2015 21:18:42 +0200
Subject: [PATCH] ARM: dts: sun8i: Add new sun8i-a33-q8-tzx-723q4.dts file
In-Reply-To: <1441890035-3687-1-git-send-email-hdegoede@redhat.com>
References: <1441890035-3687-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150910191842.GP9885@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2015 at 03:00:35PM +0200, Hans de Goede wrote:
> The TZX 723Q4 PCB is a pcb used in some q8 case 7" A33 tablets.
> This PCB has an interesting issue, its micro sdcards slot will not work
> unless the drive-strength on the mmc pins is lowered from 30mA to 10mA.
> 
> Therefor this commit introduces a separate dts file for this board.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Queued, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150910/bdc86b6f/attachment.sig>
