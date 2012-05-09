From: olof@lixom.net (Olof Johansson)
Date: Wed, 9 May 2012 01:19:40 -0700
Subject: [GIT PULL] DaVinci fixes for v3.5
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B63E9FF67D@DBDE01.ent.ti.com>
References: <DF0F476B391FA8409C78302C7BA518B63E9FF67D@DBDE01.ent.ti.com>
Message-ID: <20120509081940.GA28404@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 01:04:42PM +0000, Nori, Sekhar wrote:
> Hi Arnd, Olof,
> 
> Please pull these DaVinci fixes for v3.5 kernel. The definition of "fix" is 
> admittedly broad here, but I did not want to create too many separate pull 
> requests either. This itself is a pretty small one as such.

Hi,

Looking at this and the cleanup pull request, I think it would make more
sense to do a combined "fixes-and-cleanups" branch that contains just
actual fixes and cleanups, and then an "soc" branch that contains the
ISR performance improvement as well as the DEBUG_LL support code.

Care to shuffle those around and send two fresh requests?


Thanks,

-Olof
