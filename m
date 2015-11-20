From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Nov 2015 12:13:42 +0100
Subject: [PATCH v3 6/9] ARM: dts: sun8i: Add simplefb node labels to
 reference at board level
In-Reply-To: <1447691908-25456-7-git-send-email-wens@csie.org>
References: <1447691908-25456-1-git-send-email-wens@csie.org>
 <1447691908-25456-7-git-send-email-wens@csie.org>
Message-ID: <20151120111342.GW32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 12:38:25AM +0800, Chen-Yu Tsai wrote:
> Some boards, such as tablets, have regulators providing power to parts
> of the display pipeline, like signal converters and LCD panels.
> 
> Add labels to the simplefb device nodes so that we can reference them
> in the board dts files to add regulator supply properties.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151120/33333a4c/attachment.sig>
