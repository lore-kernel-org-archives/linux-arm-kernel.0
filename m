From: geoff@infradead.org (Geoff Levand)
Date: Fri, 29 Jul 2016 10:08:27 -0700
Subject: [PATCH v23 0/9] arm64: add kdump support
In-Reply-To: <CAB=otbTODnOwFiLZT7bm1_MLyORQ1cx-gaeg7bm+bReaMRhYwg@mail.gmail.com>
References: <20160726075659.2290-1-takahiro.akashi@linaro.org>
 <20160726080925.GA2363@linaro.org>
 <CAB=otbTODnOwFiLZT7bm1_MLyORQ1cx-gaeg7bm+bReaMRhYwg@mail.gmail.com>
Message-ID: <1469812107.16559.37.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 2016-07-29 at 19:26 +0300, Ruslan Bilovol wrote:

> Also for some reason in case of 'load and kexec the kernel' it
> takes 1-2 minutes to start booting after I do kexec -e, need to
> investigate it further.

You could try my patch ("purgatory: Change default sha256
optimization to -O2") in my master branch:

  https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git/log/

Other have said it helped.

-Geoff
