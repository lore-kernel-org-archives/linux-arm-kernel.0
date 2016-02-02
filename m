From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Feb 2016 10:15:05 +0100
Subject: [PATCH] ARM: dts: sun9i: a80-optimus: Remove i2c3 and uart4
In-Reply-To: <1454338798-5929-1-git-send-email-wens@csie.org>
References: <1454338798-5929-1-git-send-email-wens@csie.org>
Message-ID: <20160202091505.GK4652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 10:59:58PM +0800, Chen-Yu Tsai wrote:
> i2c3 and uart4 are available on the GPIO header. Though these pins only
> have this one special function, the user may choose to use them as GPIOs
> instead.
> 
> Since our policy is not to choose what function to present on the GPIO
> headers of development boards, remove them.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160202/1c2698e5/attachment-0001.sig>
