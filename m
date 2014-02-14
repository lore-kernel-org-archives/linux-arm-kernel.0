From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Feb 2014 16:55:04 +0000
Subject: IPI_WAKEUP for arm64
In-Reply-To: <CADApbejdRvUPPwKYwhDw8RL0MZ3082Rh9g1203cY5n7TwRD7gA@mail.gmail.com>
References: <CADApbejdRvUPPwKYwhDw8RL0MZ3082Rh9g1203cY5n7TwRD7gA@mail.gmail.com>
Message-ID: <20140214165504.GB12304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 09:20:43AM +0800, Chao Xie wrote:
> Why for arm, there are IPI_WAKEUP support in smp.c while for arm64, it
> is removed.
> Is there any reason for that?

It's not needed.

-- 
Catalin
