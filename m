From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Oct 2013 16:52:20 +0100
Subject: [PATCH] clk: sunxi: fix memory leaks
In-Reply-To: <1382617513-9259-1-git-send-email-valentin.ilie@gmail.com>
References: <1382617513-9259-1-git-send-email-valentin.ilie@gmail.com>
Message-ID: <20131024155220.GA2768@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 24, 2013 at 03:25:13PM +0300, Valentin Ilie wrote:
> When the if condition is true, "fixed" and "gate" should be free'd before return.
> 
> Signed-off-by: Valentin Ilie <valentin.ilie@gmail.com>

A patch has already been submitted for this.

https://lkml.org/lkml/2013/10/18/524

Thanks anyway!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131024/f86e9e0d/attachment.sig>
