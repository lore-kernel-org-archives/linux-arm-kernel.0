From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 1 Feb 2016 15:47:11 +0100
Subject: [linux-sunxi] Problem with Allwinner H3 clocks
In-Reply-To: <56AF6B23.1010901@redhat.com>
References: <20160127175512.87caf31b5e21a1fec91507f2@free.fr>
 <56A9098A.5010107@redhat.com>
 <20160127200217.14dce96ade71cf81bc82e6f6@free.fr>
 <56A9CE3D.4020906@redhat.com> <56AA14AA.4070502@gmail.com>
 <20160128175918.78a916a8cd7bf4c0b2f2814f@free.fr>
 <20160128192931.GB32462@lukather> <56AB05EF.2090604@redhat.com>
 <20160201063731.GG32462@lukather> <56AF6B23.1010901@redhat.com>
Message-ID: <20160201144711.GE4652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 03:26:43PM +0100, Hans de Goede wrote:
> >There is, but it's opt-in, and we're not using it yet for anything but
> >the hstimers (and in that case, we don't prevent the reclocking, we
> >just take it into account).
> 
> Shouldn't we be opt-ing in then ? At least the mmc driver makes
> clk_set_rate calls, it would be bad if that somehow ends up changing the
> pll6 rate while other peripherals are using it.

Well, no one will change the pll6 rate at the moment.

Adding code for some case that will not arise doesn't seem very useful

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160201/fce0cbfc/attachment.sig>
