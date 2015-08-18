From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Aug 2015 17:32:08 +0200
Subject: [PATCH v2] ARM: dts: sunxi: Add regulators for LeMaker BananaPi
In-Reply-To: <20150804090224.4B5676C83963@dd34104.kasserver.com>
References: <1438532305-5884-1-git-send-email-public_timo.s@silentcreek.de>
 <20150803094723.GD2564@lukather>
 <20150804090224.4B5676C83963@dd34104.kasserver.com>
Message-ID: <20150818153208.GF2547@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 04, 2015 at 11:02:24AM +0200, Timo Sigurdsson wrote:
> Hi Maxime,
> 
> Maxime Ripard schrieb am 03.08.2015 11:47:
> > What regulator provides the 3.3V regulator used in the rest of this DT
> > then (MMC, GMAC) ?
> 
> For GMAC, there is a reg_gmac_3v3 defined in sun7i-a20-bananapi.dts [1].
> MMC uses reg_vcc3v3 included from sunxi-common-regulators.dtsi. Am I
> missing something? Is this not sufficient?

Well, this 3.3v regulator doesn't appear out of nowhere. Most likely,
it's either one of the AXP output, or a regulator directly taking the
5v output of the DC plug.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150818/d5790184/attachment.sig>
