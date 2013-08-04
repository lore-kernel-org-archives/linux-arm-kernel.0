From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Aug 2013 13:23:00 -0700
Subject: [GIT PULL] ARM: mvebu: fixes-non-critical for v3.12
In-Reply-To: <20130725174132.GO23879@titan.lakedaemon.net>
References: <20130725174132.GO23879@titan.lakedaemon.net>
Message-ID: <20130804202300.GB15602@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 01:41:32PM -0400, Jason Cooper wrote:
> 
> The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:
> 
>   Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/fixes-non-3.12

Hi Jason,

I pulled this, but I was wondering if you'd mind holding back on basing your
branches on the very latest -rc all the time, and instead go almost as far back
as you can without merge conflicts? In particular for those who have trivial
contents such as these.

Main reason is to avoid bringing in new -rcs in the next/* branches too often,
since there's _usually_ not a need for it.

Of course, the opposite condition tends to frustrate me too, i.e. if someone
sends a pull request for the merge window that conflicts with fixes they've
already sent that has gone in. So please watch out for that. :)


-Olof
