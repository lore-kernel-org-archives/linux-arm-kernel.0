From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Mar 2017 12:18:48 +0000
Subject: [PATCH v2] arm: Fix memory attribute inconsistencies when using
 fixmap
In-Reply-To: <CAKv+Gu8VoSLOUiNSXsrtQUr8TQdGBqiOmhsKS+N2dhToMusOUg@mail.gmail.com>
References: <20170321173030.7751-1-tixy@linaro.org>
 <1490117781.3136.9.camel@linaro.org>
 <CAKv+Gu82PsyyC=fQHxUn5mrCdmQvhwK+DK342-vv8y53mLcpng@mail.gmail.com>
 <1490175988.2890.1.camel@linaro.org>
 <CAKv+Gu8VoSLOUiNSXsrtQUr8TQdGBqiOmhsKS+N2dhToMusOUg@mail.gmail.com>
Message-ID: <20170322121847.GE21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 12:13:40PM +0000, Ard Biesheuvel wrote:
> I think build testing is reasonable: the routines we call are all
> stubbed out for nommu anyway, and most changes are local to mmu.c, so
> I don't see how this would change behavior on nommu (famous last
> words)

I'm hoping to finally get some regular testing of nommu in place
during the next few weeks, so hopefully the stability of nommu from
the arch code point of view should get better.  Individual platforms
are a different matter.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
