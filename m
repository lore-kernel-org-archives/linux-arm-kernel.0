From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 15 Oct 2016 15:35:49 +0100
Subject: [PATCH v3 0/7] arm64: Privileged Access Never using TTBR0_EL1
 switching
In-Reply-To: <CAGXu5jKMZTo7m=ygm7x8w__1my0jiQiVAiv9NowQ8pfQqCnjmw@mail.gmail.com>
References: <1473788797-10879-1-git-send-email-catalin.marinas@arm.com>
 <CAGXu5jKMZTo7m=ygm7x8w__1my0jiQiVAiv9NowQ8pfQqCnjmw@mail.gmail.com>
Message-ID: <20161015143548.GA31114@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kees,

On Fri, Oct 14, 2016 at 02:44:33PM -0700, Kees Cook wrote:
> Just checking in on this feature -- I don't see it in -next nor
> already in the tree. Is there any chance this is going to make the
> v4.9 merge window?

As I said in the cover letter, I'll rebase it on top of 4.9-rc1 as there
are some clean-ups that this series would conflict with. So I am
targeting 4.10 with this patch series.

> It didn't sound like there were any unresolved issues remaining?

There are a few issues spotted by Mark which I'll address in the next
version, but nothing major.

-- 
Catalin
