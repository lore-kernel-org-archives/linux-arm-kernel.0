From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 17 May 2014 18:42:35 +0200
Subject: [PATCH 0/5] ARM: sun6i: Switch to enable-method for SMP
In-Reply-To: <1397847713-28418-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1397847713-28418-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140517164235.GM29258@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 18, 2014 at 09:01:48PM +0200, Maxime Ripard wrote:
> The recent introduction of CPU_METHOD_OF_DECLARE allowed to deprecate
> one more fiel of the struct machine_desc.
> 
> Switch to it for the Allwinner A31 SoC.

Merged the whole series.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140517/011b9265/attachment-0001.sig>
