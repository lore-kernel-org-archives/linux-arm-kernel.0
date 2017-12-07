From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 7 Dec 2017 09:46:31 +0100
Subject: [PATCH 1/2] arm64: defconfig: enable MUSB HDRC along with
 Allwinner glue
In-Reply-To: <1512582598-24806-1-git-send-email-jagan@amarulasolutions.com>
References: <1512582598-24806-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <20171207084631.ddncr4ska56u5f4n@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 11:19:58PM +0530, Jagan Teki wrote:
> Allwinner SoCs typically have a Mentor Graphics Inventra MUSB
> dual role controller for USB OTG. This is need for verifying
> gadget functions, so enable them by default.
> 
> Tested 'otg' mode with mass storage function.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171207/ab142b93/attachment.sig>
