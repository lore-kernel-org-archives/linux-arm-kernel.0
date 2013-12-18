From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 17 Dec 2013 17:05:18 -0800
Subject: [GIT PULL v4][for 3.14] pull request for hisilicon soc
In-Reply-To: <52AC0C41.2040607@gmail.com> (Haojian Zhuang's message of "Sat,
 14 Dec 2013 15:44:01 +0800")
References: <52AC0C41.2040607@gmail.com>
Message-ID: <874n67m0j5.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

Haojian Zhuang <haojian.zhuang@gmail.com> writes:

> Hi Olof/Kevin,
>
> Now I fix the wrong pull request. Here's the updated for hisilicon
> soc. Please help to merge it.
>
>    Changes from v2 is in below. Since v3 is wrong, let's drop it.
>     1. Update the git repository address from ssh:// to git://.
>     2. Add clock binding in DTS file. This patch is contained in v11
> & v12 patch sets, and everybody like this binding.
>     3. Add the GPIOLIB selection by default.
>

This series still has many issues, and you'll see a handful of comments
on the individual patches of your v12 series.

Fortunately for you, I'm getting ready to take a couple weeks off and it
is the season of giving and generosity, so I succumbed to the spirit of
the holiday season and fixed them all up myself.  (Do note though that
you only get one gift like this per year.)  ;)

Seriously though, I spent way more time on this pull request (about an
hour) than I normally spend and I was very close to requesting another
respin.  I know that you're frustrated also that it's taken so long, but
I hope you understand that when we keep seeing lots of minor problems
like we have, it requires us to spend lots of extra time, and then
forces us to look even closer the next time because we're expecting
problems.  Please take some extra care next time, and possibly ask some
colleagues to do the same.

So, with all that... the updated series is now merged into next/soc.

Kevin
