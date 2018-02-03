From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 03 Feb 2018 15:23:28 +0800
Subject: [PATCH 1/3] net: stmmac: dwmac-sun8i: drop V3s compatible and add
 V3 one
In-Reply-To: <20180202221301.judzaafcu67h4c2v@flea.lan>
References: <20180202180456.60378-1-icenowy@aosc.io>
 <20180202180456.60378-2-icenowy@aosc.io>
 <20180202221301.judzaafcu67h4c2v@flea.lan>
Message-ID: <73B89FC1-9A58-4B08-80C0-971E1254CFD9@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?2?3? GMT+08:00 ??6:13:01, Maxime Ripard <maxime.ripard@bootlin.com> ??:
>On Sat, Feb 03, 2018 at 02:04:54AM +0800, Icenowy Zheng wrote:
>> The V3s is just a differently packaged version of the V3 chip, which
>has
>> a MAC with the same capability with H3. The V3s just doesn't wire out
>> the external MII/RMII/RGMII bus. (V3 wired out it).
>> 
>> Drop the compatible string of V3s in the dwmac-sun8i driver, and add
>a
>> V3 compatible string, which has all capabilities.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>
>This breaks the DT ABI, so NAK.

I have asked this at IRC.

The V3s compatible string is never used in any mainline
kernel, even not in any RC version.

>
>Maxime
