From: greg@kroah.com (Greg KH)
Date: Thu, 1 Mar 2018 17:46:30 +0100
Subject: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Message-ID: <20180301164630.GB23321@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 08:53:37PM +0800, Alex Shi wrote:
> Hi All,
> 
> Resent without non-upstream patches.
> 
> This backport patchset fixed the spectre issue, it's original branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
> A few dependency or fixingpatches are also picked up, if they are necessary
>  and no functional changes.
> 
> No bug found from kernelci.org and lkft testing. It also could be gotten from:
> 
> git://git.linaro.org/kernel/linux-linaro-stable.git v4.9-spectre-upstream-only

Also, how did you test, what platforms did you test, and did you test
that this actually did fix the spectre issue on your platforms?  If so,
what test did you use?

thanks,

greg k-h
