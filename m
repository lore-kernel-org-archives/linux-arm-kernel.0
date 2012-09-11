From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 11 Sep 2012 19:32:44 +0200
Subject: arm: mvebu: improve Kconfig options handling for pinctrl
In-Reply-To: <1347377834-19402-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347377834-19402-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <504F75BC.1070805@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2012 05:37 PM, Thomas Petazzoni wrote:
> This small patch set splits the Armada 370 and XP Kconfig option into
> three options (one hidden common option, two visible options), and
> then uses those two options to select the appropriate pinctrl driver.
>
> Sebastian, would you mind carrying them in your pinctrl patch set? Or
> has your patch set already been merged by Jason, in which case Jason
> could handle those two patches as well? Please let me know what
> solution you chose and if I need to rebase this on a specific
> branch. For now, it's based on top of the v3 of the pinctrl-mvebu
> driver.

Thomas,

as the linux-arm-kernel is already on this discussion, I'll not remove
it on this one. But with future RFC patches we should be more careful
who the patch is sent to.

I'd like to have pinctrl-mvebu patch set separated from this Kconfig
patch set. Not because it doesn't fit but because I don't want to
respin the pinctrl patch. Posting v3 without in-depth review of my
own was a mistake. A final v4 will get offending patches right.

For this patch set I will comment on the single patch emails.

Sebastian
