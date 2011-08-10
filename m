From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Aug 2011 16:12:51 +0200
Subject: [PATCH 0/6] spi/spi-pl022 fixes
In-Reply-To: <CAKnu2MoTQTYMa4JvWyr7sPMhPyziTtnLeZLySUYxcuQC2Vu-6Q@mail.gmail.com>
References: <cover.1312887860.git.viresh.kumar@st.com>
	<4E420144.4010001@st.com>
	<CAKnu2MoTQTYMa4JvWyr7sPMhPyziTtnLeZLySUYxcuQC2Vu-6Q@mail.gmail.com>
Message-ID: <201108101612.51825.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 August 2011, Linus Walleij wrote:
> The basic assumption is that patches are orthogonal and apply
> without conflicts, i.e. patch different parts of the kernel tree or
> different lines in the same file.
> 
> Second assumption is that if patches do collide, the subsystem
> maintainer can solve most conflicts, and is expected to do
> so. Torvalds sets an example by requesting that subsystem
> maintainers do not fixup conflicts between subsystems so he
> can see them himself.
> 
> Then there are special cases when you get a strong
> coupling between patches.
> 
> In these special cases, ask the subsystem maintainer what to
> base the patches on. Usually it's some commit on the subsystem
> tree rather than -next.
> 
> This is my understanding of how we work, maybe I should
> patch Documentation/development-process/*, Arnd do you have
> anything to add?

No, your explanations are pretty much what I would have said.

	Arnd
