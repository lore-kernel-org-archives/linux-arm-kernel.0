From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Apr 2017 14:17:18 +0200
Subject: [PATCH v4 8/8] ARM: sun8i: sina33: add highest OPP of CPUs
In-Reply-To: <20170405090634.4649-9-quentin.schulz@free-electrons.com>
References: <20170405090634.4649-1-quentin.schulz@free-electrons.com>
 <20170405090634.4649-9-quentin.schulz@free-electrons.com>
Message-ID: <20170405121718.4lldpkcnfoxgrsmo@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 05, 2017 at 11:06:34AM +0200, Quentin Schulz wrote:
> The A33 supports 1.1GHz and 1.2GHz frequencies at 1.32V and the Sinlinx
> SinA33 has its cpu-supply property set in the cpu DT node.
> 
> Therefore, CPUfreq knows how to handle the regulator in charge of the
> CPU and can adjust its voltage to match the OPP.
> 
> Add these two CPU frequencies to the CPU OPP table of the Sinlinx
> SinA33.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

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
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170405/cf8eec41/attachment.sig>
