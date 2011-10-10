From: olof@lixom.net (Olof Johansson)
Date: Mon, 10 Oct 2011 11:09:19 -0700
Subject: Please update linux-next url for tegra
Message-ID: <CAOesGMjT+vyC8Jsjshrcz2f2xC=VEw+dTQh-rqLpjJMH5OJnag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

I'm taking over running the main tegra repo for a while, so please
change the old android.git.kernel.org-hosted branch to instead pull:

git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git for-next

And please pull it after the arm-soc tree.

I don't expect to have much long-lived contents in here -- they should
find their way into arm-soc quickly. But I also want to get patches
into linux-next as soon as possible without sending arm-soc pull
requests every few days.


-Olof
