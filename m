From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Aug 2013 10:41:57 +0200
Subject: [PATCHv3 0/4] Add support for the Allwinner A31 clocks
In-Reply-To: <1375735381-18214-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1375735381-18214-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130812084157.GP2911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Emilio,

On Mon, Aug 05, 2013 at 10:42:57PM +0200, Maxime Ripard wrote:
> Hi everyone,
> 
> The Allwinner A31 SoC has a quite different clock tree and structure that the
> other Allwinner SoCs that we already merged, so it requires more work than what
> we had for the other SoCs until now.
> 
> It's also an opportunity to do some minor cleanup/refactoring to land the new
> code properly.
> 
> This patch set is based on the "ARM: sunxi: Add support for the Allwinner A31
> SoC" serie I sent previously.

It would be great if this could go in 3.12.
Could you review these patches? The two first should be trivial, only
the third one isn't and adds the basic A31 clocks support to the driver.

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
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130812/912225fc/attachment.sig>
