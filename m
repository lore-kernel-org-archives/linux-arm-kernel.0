From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 8 Mar 2015 22:43:49 +0100
Subject: [PATCH 3/3] ARM: dts: sunxi: Adjust touchscreen compatible for
 sun5i and later
In-Reply-To: <1425848022-18001-4-git-send-email-hdegoede@redhat.com>
References: <1425848022-18001-1-git-send-email-hdegoede@redhat.com>
 <1425848022-18001-4-git-send-email-hdegoede@redhat.com>
Message-ID: <20150308214349.GM5085@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 08, 2015 at 09:53:42PM +0100, Hans de Goede wrote:
> The touchscreen controller in the A13 and later has a different temperature
> curve than the one in the original A10, change the compatible for the A13 and
> later so that the kernel will use the correct curve.
> 
> Reported-by: Tong Zhang <lovewilliam@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150308/dd932ba1/attachment.sig>
