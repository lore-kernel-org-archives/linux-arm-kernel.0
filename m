From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 15 Dec 2014 17:56:55 +0100
Subject: Linus' tree (master) not working for Allwinner sun4i, sun5i,
 sun7i SoC-s + fix
In-Reply-To: <548F0C8C.3030006@gmail.com>
References: <548F0C8C.3030006@gmail.com>
Message-ID: <20141215165655.GL4337@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 15, 2014 at 05:30:04PM +0100, Hans de Goede wrote:
> Hi Maxime,
> 
> Somehow this commit of your sunxi/clocks-for-3.19 branch has made it
> into Linus' tree:
> 
> https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/commit/?h=sunxi/clocks-for-3.19&id=93746e70be83a3f113134a16065957b324af50f7
> 
> But this one has not:
> 
> https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/commit/?h=sunxi/clocks-for-3.19&id=acbcc0f03b15585387f9ca69c2a976b02cb69023
> 
> Rather badly breaking Allwinner sun4i, sun5i, sun7i SoC-s.

I don't know what you are looking at, but I don't see any of these
commits in Linus' current master, either in the git repo itself, or
using the kernel.org git interface.

They're both part of Mike Turquette's clk-next though, so they should
both land just fine whenever that will be merged.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141215/afac3ffd/attachment.sig>
