From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Oct 2011 15:07:38 +0200
Subject: [GIT PULL] GIC DT binding support
In-Reply-To: <4E97A601.1020005@gmail.com>
References: <4E97A601.1020005@gmail.com>
Message-ID: <201110201507.38722.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 October 2011, Rob Herring wrote:
> Please pull GIC device tree support. This is the first of 2 pull
> requests. You can ignore this one if there are no other dependencies on
> GIC DT support.
> 
> This is based on rmk's for-next branch and v3.1-rc9. rc9 was needed for
> this dependency:

I don't see the for-next branch in the history. Do you mean it requires
the for-next branch as well in order to actually build?

Can you be more specific so I can watch for the dependencies to
get upstream first?

> The following changes since commit dd5e9eb0d051606ee3eda0c30222429c74e23f00:
> 
>   Merge commit 'v3.1-rc9' into upstream/base (2011-10-13 20:30:42 -0500)
> 
> are available in the git repository at:
> 
>   http://sources.calxeda.com/git/kernel/linux.git gic-dt

Pulled into my next/dt branch, thanks a lot!

	Arnd
