From: lkp@intel.com (Fengguang Wu)
Date: Mon, 18 Jul 2016 20:41:22 +0800
Subject: running "make dtbs" for test builds
In-Reply-To: <8924490.SntxSU2FOC@wuerfel>
References: <8924490.SntxSU2FOC@wuerfel>
Message-ID: <20160718124122.GA30497@wfg-t540p.sh.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Jul 18, 2016 at 02:01:17PM +0200, Arnd Bergmann wrote:
>Hi Fengguang,
>
>I've recently run into a number of cases in which I pulled a branch that
>was building fine with "make vmlinux", but that failed for "make dtbs",
>and I wonder if this is something that could be checked by the kbuild
>test robot so we catch it earlier.

We initially run "make" without vmlinux, however during bisect more
specific make targets will be used to speed it up. To do that it's
necessary to know the regex patterns of "make dtbs" error messages,
so that they can be correctly bisected.

Can you give some "make dtbs" error messages or patterns?

Thanks,
Fengguang
