From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Apr 2013 02:51:46 -0700
Subject: [GIT PULL][for 3.10] pull request from armsoc/pxa branch in pxa
 git tree
In-Reply-To: <CAN1soZzqag7W3Yz07-2KV-4BVd1eN0dYMiFhsg6+NEc1hRZKjg@mail.gmail.com>
References: <CAN1soZzqag7W3Yz07-2KV-4BVd1eN0dYMiFhsg6+NEc1hRZKjg@mail.gmail.com>
Message-ID: <20130411095146.GF31465@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 10:30:30AM +0800, Haojian Zhuang wrote:
> Hi Arnd & Olof,
> 
> Please help to merge armsoc/pxa branch from pxa git tree.
> 
> Regards
> Haojian
> 
> The following changes since commit 31880c37c11e28cb81c70757e38392b42e695dc6:
> 
>   Linux 3.9-rc6 (2013-04-07 20:49:54 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/hzhuang1/linux.git armsoc/pxa

Thanks. These short branches for "minor" platforms don't really fit in our
flow of categories. I wonder if we should start a separate next/ category for
them next release.

Anyway, since this modifies a bunch of board files to deal with the new gpio
config, I've merged it somewhat randomly into next/boards.


-Olof
