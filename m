From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Dec 2015 09:22:07 +0100
Subject: [PATCH 1/3] ARM: dts: sun7i: Olimex A20-SOM-EVB: Add LRADC keys
In-Reply-To: <1449779521-754-2-git-send-email-merker@debian.org>
References: <1449779521-754-1-git-send-email-merker@debian.org>
 <1449779521-754-2-git-send-email-merker@debian.org>
Message-ID: <20151211082207.GK27957@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 10, 2015 at 09:31:59PM +0100, Karsten Merker wrote:
> The Olimex A20-SOM-EVB is an evaluation board for the Olimex
> A20-SOM system-on-module.  It provides a set of android-style
> buttons (labeled "VOL+", "VOL-", "MENU", "SEARCH", "HOME", "ESC"
> and "ENTER") which are connected to a low-resolution ADC via a
> resistor network.
> 
> This patch adds appropriate button definitions to the board
> dts. The voltages assigned to the keys are specified in the
> board schematics published by the manufacturer.
> 
> Signed-off-by: Karsten Merker <merker@debian.org>

Applied 1 and 2, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151211/2ed9bb8c/attachment-0001.sig>
