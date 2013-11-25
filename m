From: olof@lixom.net (Olof Johansson)
Date: Sun, 24 Nov 2013 20:05:00 -0800
Subject: [GIT PULL][for 3.14] pull request to enable Hisilicon SoC from
 pxa git tree
In-Reply-To: <5292BEFC.4080403@gmail.com>
References: <5292BEFC.4080403@gmail.com>
Message-ID: <CAOesGMjomMk205LQojzO2-zyjvnxtUh_gkfd74WgB4TWbnxDYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Sun, Nov 24, 2013 at 7:07 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> Hi Olof & Kevin,
>
> Here's the pull request from pxa git tree to enable Hisilicon Hi3620 SoC.
> Please help to merge.
>
> Best Regards
> Haojian
>
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
>
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
>
> are available in the git repository at:
>
>   http://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git
> tags/hisilicon-init

Hi,

Overall this looks good, but I do have a few comments:

First, I had a comment on one of the patches. It's your choice if you
want to address it by respinning or by an incremental patch on top,
but please address those.

Second, it seems appropriate for you to start a second git tree for
hisilicon, instead of reusing the pxa one -- at least if you expect
more activity on that platform over time. You can create new trees on
kernel.org as you see fit, so there's no reason not to.

Thirdly, I noticed some patches have a Signed-off-by from your linaro
address, and a committer ID of your gmail account. Please be
consistent in which one you use since last S-o-b and committer should
match -- you might want to reconfigure git to use the linaro one but
either way is fine with me as long as it is consistent.

Finally, you've had a lot of review cycles, but surprisingly not many
acked-by's on the final patches. See if you can get some out of the
people whose feedback you have addressed.


Since you have to rebuild the branch to fix committer id, you might
want to just fold in the changes from my review, but I'll leave that
up to you.

-Olof
