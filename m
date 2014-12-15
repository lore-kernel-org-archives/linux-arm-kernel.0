From: j.w.r.degoede@gmail.com (Hans de Goede)
Date: Mon, 15 Dec 2014 17:30:04 +0100
Subject: Linus' tree (master) not working for Allwinner sun4i, sun5i, sun7i
 SoC-s + fix
Message-ID: <548F0C8C.3030006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Somehow this commit of your sunxi/clocks-for-3.19 branch has made it into Linus' tree:

https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/commit/?h=sunxi/clocks-for-3.19&id=93746e70be83a3f113134a16065957b324af50f7

But this one has not:

https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/commit/?h=sunxi/clocks-for-3.19&id=acbcc0f03b15585387f9ca69c2a976b02cb69023

Rather badly breaking Allwinner sun4i, sun5i, sun7i SoC-s.

Regards,

Hans
