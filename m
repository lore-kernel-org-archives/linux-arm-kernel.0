From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Feb 2016 14:24:21 +0100
Subject: [PATCH] pinctrl: sunxi: H3 requires irq_read_needs_mux
In-Reply-To: <20160202100217.GA7483@box2.japko.eu>
References: <20160202100217.GA7483@box2.japko.eu>
Message-ID: <20160202132421.GT4652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 11:03:03AM +0100, Krzysztof Adamski wrote:
> It seems that on H3, just like on A10, when GPIOs are configured as
> external interrupt data registers does not contain their value.  When
> value is read, GPIO function must be temporary switched to input for
> reads.
> 
> Signed-off-by: Krzysztof Adamski <k@japko.eu>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160202/d89e8160/attachment.sig>
