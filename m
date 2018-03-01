From: greg@kroah.com (Greg KH)
Date: Thu, 1 Mar 2018 16:24:50 +0100
Subject: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Message-ID: <20180301152450.GA4061@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 11:56:22AM +0800, Alex Shi wrote:
> Hi All,
> 
> This backport patchset fixed the meltdown issue, it's original branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
> A few dependency or fixingpatches are also picked up, if they are necessary
>  and no functional changes.
> 
> The patchset also on repository:
> 	git://git.linaro.org/kernel/linux-linaro-stable.git lts-4.9-spectrevv2 
> 
> No bug found yet from kernelci.org and lkft testing.

No bugs is good, but does it actually fix the meltdown problem?  What
did you test it on?

And why are you making this patchset up?  What is wrong with the patches
in the android-common tree for this?

> Any comments are appreciated!

You need to start versioning this changeset, as I have no idea if this
is the "latest" one or not, right?

Or have you not sent out this patchset before?  How does this interact
with the "spectre" patches?  Or am I totally confused here?

thanks,

greg k-h
