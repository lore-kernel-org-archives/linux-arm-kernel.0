From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 9 Sep 2016 16:38:24 +0200
Subject: [PATCH v5 2/3] mfd: add support for Allwinner SoCs ADC
In-Reply-To: <1473344917-1524-3-git-send-email-quentin.schulz@free-electrons.com>
References: <1473344917-1524-1-git-send-email-quentin.schulz@free-electrons.com>
 <1473344917-1524-3-git-send-email-quentin.schulz@free-electrons.com>
Message-ID: <20160909143824.GD8881@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 04:28:36PM +0200, Quentin Schulz wrote:
> The Allwinner SoCs all have an ADC that can also act as a touchscreen
> controller and a thermal sensor. For now, only the ADC and the thermal
> sensor drivers are probed by the MFD, the touchscreen controller support
> will be added later.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160909/5cfdc709/attachment.sig>
