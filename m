From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 16 Nov 2014 11:02:47 +0100
Subject: [PATCH RESEND] ARM: sunxi: make sun6i SMP ops static
In-Reply-To: <1416095618-2900-1-git-send-email-emilio@elopez.com.ar>
References: <1416095618-2900-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <20141116100247.GE6414@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 15, 2014 at 08:53:38PM -0300, Emilio L?pez wrote:
> The sun6i SMP ops are currently not marked as static, as reported by
> sparse. Let's mark it as such.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
> 
> Here's an oldish patch that never made it to mainline. I rediscovered it
> today while I was cleaning up stuff and running a sparse build of -rc4.
> 
> Cheers!
> 
> Emilio

Merged, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141116/59fee241/attachment.sig>
