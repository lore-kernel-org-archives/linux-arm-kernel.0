From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Sep 2015 22:03:49 +0200
Subject: [PATCH 0/4] ARM: sun8i: Fix A23 and A33 clock gates indices
In-Reply-To: <1441977997-29041-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1441977997-29041-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150918200349.GY4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 03:26:33PM +0200, Maxime Ripard wrote:
> Hi everyone,
> 
> Here is a patch set that adds the missing clocks for the message box
> in the A33 and A23 SoCs.
> 
> In order to support that properly, the addition of a new clock driver
> for the A33 has been needed, and we split the gates definition that
> was previously shared to each DTSI.
> 
> Let me know what you think,
> Maxime

Fixed the typo and applied.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150918/9e3f6857/attachment.sig>
