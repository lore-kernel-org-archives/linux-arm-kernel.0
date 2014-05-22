From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 May 2014 22:15:22 -0700
Subject: [GIT PULL] SOCFPGA DTS updates for 3.16, take 2
In-Reply-To: <1400471241-21456-1-git-send-email-dinguyen@altera.com>
References: <1400471241-21456-1-git-send-email-dinguyen@altera.com>
Message-ID: <20140522051522.GB32618@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 18, 2014 at 10:47:21PM -0500, dinguyen at altera.com wrote:
> Hi Arnd, Kevin and Olof,
> 
> Please consider pulling in this patch for 3.16. This patch adds the DTS
> entries for the GPIOs on the SOCFPGA platform.
> 
> Olof had a question regarding how the GPIO node needed 2-layer approach.
> 
> http://thread.gmane.org/gmane.linux.kernel/1671569/focus=1702208
> 
> I hope that Alan Tull was able to answer Olof's question.
> 
> Thanks,
> 
> The following changes since commit 2bfac3a551978c4953f659e1bd18d58c3c249f64:
> 
>   Merge tag 'socfpga-dt-updates-for-3.16_v3' of git://git.rocketboards.org/linux-socfpga-next into next/dt (2014-05-16 16:07:37 -0700)

You can't base your branch on top of our next/dt. You should have based
this on top of your previous branch, and not pulled down our contents
for it.

Please send a new pull request, or let me know if you prefer me to just
cherry-pick over the one patch -- your choice.


-Olof
