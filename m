From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 22 Oct 2017 10:20:52 +0100
Subject: [PATCH v2 0/8] arm/arm64: KVM: limit icache invalidation to
 prefetch aborts
In-Reply-To: <20171020154904.31427-1-marc.zyngier@arm.com> (Marc Zyngier's
 message of "Fri, 20 Oct 2017 16:48:56 +0100")
References: <20171020154904.31427-1-marc.zyngier@arm.com>
Message-ID: <86o9ozh72j.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20 2017 at  4:48:56 pm BST, Marc Zyngier <marc.zyngier@arm.com> wrote:

[...]

> * From v1:
[...]

>   - Dropped patch #10 which was both useless and broken, and patch #9
>     that thus became useless

Tuuut!!!!! patch #9[1] is not useless at all, as it allows patch #2 to
compile. I failed to notice it because I still had #9 in my tree as I
pushed things out. Duh.

I've pushed out a branch[2] with that patch as a prerequisite. Let me
know if I should repost the whole thing.

Sorry for the fsckup,

	M.

[1] https://patchwork.kernel.org/patch/9993695/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/icache
-- 
Jazz is not dead. It just smells funny.
