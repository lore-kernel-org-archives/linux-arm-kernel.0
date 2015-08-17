From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Aug 2015 17:18:51 +0200
Subject: [PATCH v2] ARM: dts: sunxi: Raise minimum CPU voltage for
 sun7i-a20 to meet SoC specifications
In-Reply-To: <1438722481-2302-1-git-send-email-public_timo.s@silentcreek.de>
References: <1438722481-2302-1-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <20150817151851.GE2547@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Timo,

On Tue, Aug 04, 2015 at 11:08:01PM +0200, Timo Sigurdsson wrote:
> sun7i-a20.dtsi contains a cpufreq operating point at 0.9 volts. The minimum
> CPU voltage for the Allwinner A20 SoC, however, is 1.0 volts. Thus, raise
> the voltage for the lowest operating point to 1.0 volts in order to stay
> within the SoC specifications. It is an undervolted setting that isn't
> stable across all SoCs and boards out there.
> 
> Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>

Added Iain's Ack, and Cc stable

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150817/fb0da564/attachment.sig>
