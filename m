From: Ian.Jackson@eu.citrix.com (Ian Jackson)
Date: Tue, 23 Aug 2011 18:15:43 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20051.56441.597373.780997@mariner.uk.xensource.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CA+wbFdcv_BsHaVwoqgF5yx6scXOodHkKjdVtarqJwjy_GFrAJQ@mail.gmail.com>
	<20051.56441.597373.780997@mariner.uk.xensource.com>
Message-ID: <20051.57407.858233.386281@mariner.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I wrote:
> I haven't checked the decompressor but I don't see why it wouldn't
> work in hyp mode.  I can try it easily enough.

I tried booting linux in non-secure hyp mode [1] and it seemed to work
just fine.  The kernel decompressed and booted up to trying to mount
its root fs, just like it does if you start it in secure kernel mode.

Ian.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-2.6-cm.git
    a104d064b95e4981619c66bb94840ab3cb67c75d
