From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Sep 2014 13:31:33 +0200
Subject: [PATCH v3 00/12] clk: sunxi: Improve MMC clocks support
In-Reply-To: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140922113133.GF15315@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

On Thu, Sep 11, 2014 at 10:18:14PM +0200, Maxime Ripard wrote:
> Hi everyone,
> 
> Here is an attempt at improving the MMC clock support in the Allwinner
> SoCs.
> 
> Until now, the MMC clocks were having a custom phase function that was
> directly setting an obscure value in the right register, because we
> were not really having any idea of what these values were.
> 
> Now that we have more informations, we can introduce a common function
> call to get and set the phase of a particular clock, and use this in
> both our provider and our client.

It would be great that we have that custom phase API out of the kernel
for 3.18, and you were one of the greatest supporters to that idea,
could we please have your view on this?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140922/b6ddffc8/attachment.sig>
