From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Oct 2015 20:05:13 +0200
Subject: [PATCH] ARM: dts: sun7i: Enable USB DRC on pcDuino v3 Nano
In-Reply-To: <1445119709-1689-1-git-send-email-ats@offog.org>
References: <1445119709-1689-1-git-send-email-ats@offog.org>
Message-ID: <20151019180513.GW2711@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 17, 2015 at 11:08:29PM +0100, Adam Sampson wrote:
> The OTG arrangement on the LinkSprite pcDuino v3 Nano is the same as the
> pcDuino 1/2/3: the OTG port's 5V line is connected directly to the 5V
> bus (it's not switchable), and the OTG port's ID pin is connected to PH4
> on the A20.
> 
> Tested successfully in both host and device modes.
> 
> Signed-off-by: Adam Sampson <ats@offog.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151019/9ac4f840/attachment.sig>
