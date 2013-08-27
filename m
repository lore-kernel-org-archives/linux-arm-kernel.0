From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 27 Aug 2013 23:02:01 +0100
Subject: 3.11-rc7 big-endian support
In-Reply-To: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <521D21D9.8020106@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/08/13 22:38, Ben Dooks wrote:
> This is a new series of the core work for getting big-endian working
> nicely on ARM. This is mainly a rebase on 3.11-rc7 and has not had
> a lot of testing on it.
>
> It is available on:
>
> 	git://git.baserock.org/delta/linux.git baserock/311-rc7/be/core-v1
>
> Since the previous version:
>
> - Added Victor's atomic64 patch
> - Fixed BUG() patch to use<asm/opcodes.h>
>
> I would like to get as much of this merged as possible, so would
> it be possible

Is it possible to get all or some of this series pulled before the
next merge window? Do I need to remove the machine specific parts
of the series?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
