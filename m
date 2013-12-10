From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 09 Dec 2013 16:06:06 -0800
Subject: [GIT PULL][v2] pull request for hisilicon soc
In-Reply-To: <529EF3CB.5040505@gmail.com> (Haojian Zhuang's message of "Wed,
 04 Dec 2013 17:20:11 +0800")
References: <529EF3CB.5040505@gmail.com>
Message-ID: <87fvq16041.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@gmail.com> writes:

> Hi all,
>
> Please help to merge this pull request.
>
> I have to use gmail address since my GPG key is based on gmail.com.
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
> ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git
> tags/hisilicon-basic

Please use git:// URLs instead of SSH URLs.

Also, does this replace the previous pull request from the pxa tree?

I assume so since the original tag doesn't exist anymore, but it would
be good for you to state explicitly that it superceeds a previous pull
request or adds to it.

Also, it's not easy to see what is different in this pull request from
your v11.  There were a few comments on v11 that you responded to but
never posted a v12.  Does that mean they were fixed in this pull
request?  Again, I can check this manually but would much prefer it be
described here, or have seen v12 with the issues addressed and a pull
request based on that.

Olof also suggested you attempt to collect some reviewed-by/acked-by
tags.  Were you able to do that?

Kevin
