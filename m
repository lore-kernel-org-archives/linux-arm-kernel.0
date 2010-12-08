From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 08 Dec 2010 00:45:35 +0000
Subject: CpuFreq for mini2440
In-Reply-To: <AANLkTi=55k8Dr6CAe6O92j6P2ht4D+onFAEu7J0Q+Nvn@mail.gmail.com>
References: <AANLkTi=55k8Dr6CAe6O92j6P2ht4D+onFAEu7J0Q+Nvn@mail.gmail.com>
Message-ID: <4CFED52F.8070307@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/10 01:12, tarek attia wrote:
> Hi all,
> 
> I tried many times to enable the Cpufreq for the mini2440 "Friendly
> Arm board" but each time I enable it in the kernel it ended up by a
> successful compilation ,but when I mount the kernel image on the board
> ,just I dun find it's folder nor it's kernel objects,,,what I miss
> ,,or what track should I go to make it working ?

The board's init code may not support it. If no-one else comes
forward, I will try as I think I still have one of these boards
somewhere.
