From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Sep 2015 16:40:40 +0200
Subject: [PATCH 2/4] ARM: sun8i: Add the A33 AHB1 gates clock driver
In-Reply-To: <87wpvu2vzr.fsf@dell.be.48ers.dk>
References: <1441977997-29041-1-git-send-email-maxime.ripard@free-electrons.com>
 <1441977997-29041-3-git-send-email-maxime.ripard@free-electrons.com>
 <87wpvu2vzr.fsf@dell.be.48ers.dk>
Message-ID: <20150914144040.GD4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Sun, Sep 13, 2015 at 05:13:12PM +0200, Peter Korsgaard wrote:
> >>>>> "Maxime" == Maxime Ripard <maxime.ripard@free-electrons.com> writes:
> 
>  > The A33 has different a different gates array than the A23, add the node to
>  > the DT.
> 
> NIT: 2x different.

Ah, good catch, thanks!

> Shouldn't the a23 one then move from sun8i-a23-a33.dtsi to
> sun8i-a23.dtsi?

It is, but in order to preserve bisectability, I declared the A33 node
first, that has precedence over the A23 still in the common DTSI, and
removed the A23 in the next patch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150914/a3566487/attachment.sig>
