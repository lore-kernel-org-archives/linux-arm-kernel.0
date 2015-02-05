From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 5 Feb 2015 09:43:17 +0000
Subject: Kexec and KVM not working gracefully together
In-Reply-To: <54D30AE0.5050101@linaro.org>
References: <CAHt6W4cuRi3bfj5mryFouhOLGAAWuNXKVvz4K-rAjQnwiegL-Q@mail.gmail.com>
 <54C7ADF0.8090102@arm.com> <54D30AE0.5050101@linaro.org>
Message-ID: <20150205094317.43f8554a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Feb 2015 06:17:04 +0000
AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

> Frediano
> Cc: Marc
> 
> Are you going to fix this issue on arm?
> As I'm now working on the same issue on arm64,
> we should share the idea and some code.

Just to be perfectly clear: KVM support for Kexec on arm and arm64
should be exactly the same, with the exception of some (very
limited) assembly code for the MMU teardown.

And I'd like to see both architectures addressed at the same time,
without statements such as "we'll do that as a next step". As such, I'd
very much recommend that Frediano and you work together to address this
problem.

Thanks,

        M.
-- 
Jazz is not dead. It just smells funny.
