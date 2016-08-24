From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Aug 2016 08:15:52 +0200
Subject: [PATCH] clk: core: Force setting the phase delay when no change
In-Reply-To: <20160813164412.2671726A@mail.free-electrons.com>
References: <20160813164412.2671726A@mail.free-electrons.com>
Message-ID: <20160824061552.GA8103@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Aug 13, 2016 at 06:23:49PM +0200, Jean-Francois Moine wrote:
> The hardware phase delay may depend on some other settings as clock
> reparenting, so, it has to be set each time.
> Also, when the delay was the same as previously, an error was returned.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

Please send it to the proper maintainers.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160824/11a29fd7/attachment.sig>
