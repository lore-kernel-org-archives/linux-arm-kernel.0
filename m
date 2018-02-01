From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 Feb 2018 16:19:00 +0100
Subject: [PATCH] arm: dts: sun7i: include correct ccu clock header
In-Reply-To: <1517427086-66480-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1517427086-66480-1-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <20180201151900.2zabioxbq7iehl4v@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 31, 2018 at 08:31:26PM +0100, Giulio Benetti wrote:
> Include correct clock header sun7i-a20-ccu.h
> instead of sun4i-a20-ccu.h.

You should wrap at 72 characters.

> Including sun4i header instead of sun7i
> prevents using sun7i specific defines.
> 
> Substitute header inclusion in sun7i-a20.dtsi
> using right one.

This sentence is redundant with the first one.

Dropped the first one, corrected the wrapping and applied, thanks

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180201/d1b215ed/attachment.sig>
