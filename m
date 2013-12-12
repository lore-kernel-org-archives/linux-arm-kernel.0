From: olof@lixom.net (Olof Johansson)
Date: Wed, 11 Dec 2013 16:49:05 -0800
Subject: [GIT PULL v3][for 3.14] pull request for hisilicon soc
In-Reply-To: <52A82C02.5050609@gmail.com>
References: <52A82C02.5050609@gmail.com>
Message-ID: <20131212004905.GF21531@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 05:10:26PM +0800, Haojian Zhuang wrote:
> Hi all,
> 
> Please help to merge pull request for hisilicon soc. This pull
> request is used to replace all previous request for hisilicon. The
> changes is in below.
> 
>    1. Update the git repository address from ssh:// to git://.
>    2. Add clock binding in DTS file. This patch is contained in v11
> & v12 patch sets, and everybody like this binding.
>    3. Add the GPIOLIB selection by default.
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git
> tags/hisilicon-basic
> 
> for you to fetch changes up to be05bfccdbe65915da4a7d0e4713ad3489fd5f37:
> 
>   ARM: hi3xxx: select GPIO in Kconfig (2013-12-11 17:01:45 +0800)

Sigh.

This code is different from the patches you posted. In particular the
"add smp support" patch is different, maybe others too.


-Olof
