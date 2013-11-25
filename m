From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 25 Nov 2013 13:02:30 -0500 (EST)
Subject: [PATCH v4 REPOST] ARM: vexpress/TC2: Implement MCPM
 power_down_finish()
In-Reply-To: <CAOesGMjcNhqUikHhP-Jx5cHUocHQUTPW9p5ikwwQxbMSFM7hvQ@mail.gmail.com>
References: <1385396185-15291-1-git-send-email-Dave.Martin@arm.com>
 <CAOesGMjcNhqUikHhP-Jx5cHUocHQUTPW9p5ikwwQxbMSFM7hvQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.10.1311251259400.9667@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Nov 2013, Olof Johansson wrote:

> Hi,
> 
> > Since v3.13-rc1, mcpm backends must implement an additional method which
> > the vexpress TC2 implementation doesn't have upstream, resulting in an
> > ugly WARN_ON() during hotplug and kexec operations
> 
> Please be more specific here. Which change in the 3.13 merge window caused this?

Commit 0de0d6467525.

The corresponding change to tc2-pm.c was initially posted at about the 
same time i.e. before the merge window, but it somehow fell into a 
crack.


Nicolas
