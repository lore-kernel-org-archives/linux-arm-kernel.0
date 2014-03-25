From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 25 Mar 2014 10:00:31 +0000
Subject: [Linaro-acpi] [PATCH] arm64: Fix duplicated Kconfig entries again
In-Reply-To: <1395738060-18489-1-git-send-email-hanjun.guo@linaro.org>
References: <1395738060-18489-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <533153BF.3070308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hanjun,

On 25/03/14 09:00, Hanjun Guo wrote:
> After commit 74397174989e5 (arm64: Fix duplicated Kconfig entries),
> I still get a duplicate Power management options section in linux-next
> git repo, may be due to some merge conflicts, anyway, fix that in this
> patch.
> 
I reported this and Mark Brown posted the patch[1].
I assumed it is already pulled, but looks like that's not the case.

Regards,
Sudeep

[1] http://www.spinics.net/lists/arm-kernel/msg314472.html
