From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Mar 2011 12:56:06 +0000
Subject: [PATCH v4 08/19] ARM: LPAE: Introduce the 3-level page table
	format definitions
In-Reply-To: <AANLkTikH9tBTGCiJ-+dvhh1tajMVq_6ua41MMZmq48sC@mail.gmail.com>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-9-git-send-email-catalin.marinas@arm.com>
	<AANLkTi=d0q0Upde3=b4tpu3icOr4XdifcFRvBHuXgsBN@mail.gmail.com>
	<20110124214225.GO24104@n2100.arm.linux.org.uk>
	<AANLkTikH9tBTGCiJ-+dvhh1tajMVq_6ua41MMZmq48sC@mail.gmail.com>
Message-ID: <20110321125606.GC22222@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2011 at 12:36:55PM +0000, Catalin Marinas wrote:
> Any plans for the nopmd patches? I haven't seen them in -next or on the list.

I dropped them again because of those pesky warnings, so again I'm not
planning to push them this window as I don't wish to be deluged in
people reporting the warnings.

They really need fixing once we know how the LPAE stuff interacts with
the change.  At the moment I've no idea whether the existing section
support ends up at pgd or pmd level with LPAE.

Obviously that matters as with LPAE, pgd and pmd are different hardware
levels, but without LPAE they're the same hardware level.
