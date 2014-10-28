From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Oct 2014 21:27:08 +0100
Subject: [linux-sunxi] [PATCH 4/6] ARM: dts: sun9i: Add GPIO LEDs for A80
 Optimus board
In-Reply-To: <B1174832-BCE8-4B92-A239-1388D4C5BAAF@dominion.thruhere.net>
References: <1414489843-2680-1-git-send-email-wens@csie.org>
 <1414489843-2680-5-git-send-email-wens@csie.org>
 <B1174832-BCE8-4B92-A239-1388D4C5BAAF@dominion.thruhere.net>
Message-ID: <20141028202708.GB9255@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 12:04:28PM +0100, Koen Kooi wrote:
> 
> > Op 28 okt. 2014, om 10:50 heeft Chen-Yu Tsai <wens@csie.org> het volgende geschreven:
> > 
> > The A80 Optimus board has 3 usable LEDs that are controlled via GPIO.
> > 
> > This patch adds support for 2 of them which are driver by GPIOs in the
> > main pin controller. The remaining one uses GPIO from the R_PIO
> > controller, which we don't support yet.
> 
> Out of curiousity, are those LEDs labeled and if so, would it make
> sense to assign default triggers matching the labels to them? As a
> personal preference I tend to have one of the LEDs use the
> 'heartbeat' trigger so I can see that it's alive.

I'm not a huge fan of forcing this kind of policy decision down to the
users, especially for such "generic" boards that don't have any
labeled LEDs.

I feel like it's a userspace decision, but I don't have a strong
opinion on this :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/b04bf649/attachment.sig>
