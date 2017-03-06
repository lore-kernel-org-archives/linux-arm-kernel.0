From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Mar 2017 11:35:35 +0100
Subject: [PATCH v7 1/6] ARM: dts: sun8i: drop skeleton.dtsi inclusion in
 H3 DTSI
In-Reply-To: <20170305233138.64574-2-icenowy@aosc.xyz>
References: <20170305233138.64574-1-icenowy@aosc.xyz>
 <20170305233138.64574-2-icenowy@aosc.xyz>
Message-ID: <20170306103535.jdaiwr65gtrhh7jp@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 06, 2017 at 07:31:33AM +0800, Icenowy Zheng wrote:
> The skeleton.dtsi file is now deprecated, and do not exist in ARM64
> environment.
> 
> Since we will soon reuse most part of H3 DTSI for H5, which is an ARM64
> chip, drop skeleton.dtsi inclusion now.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Your prefix (and in the three later patches) should be
ARM: sun8i: h3

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170306/b996f653/attachment-0001.sig>
