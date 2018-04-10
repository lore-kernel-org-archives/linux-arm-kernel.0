From: Alexander.Levin@microsoft.com (Sasha Levin)
Date: Tue, 10 Apr 2018 13:49:22 +0000
Subject: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
In-Reply-To: <1522947547-24081-3-git-send-email-will.deacon@arm.com>
References: <1522947547-24081-3-git-send-email-will.deacon@arm.com>
Message-ID: <DM5PR2101MB10325D85829E62CD43128227FBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[This is an automated email]

This commit has been processed by the -stable helper bot and determined
to be a high probability candidate for -stable trees. (score: 32.4825)

The bot has tested the following trees: v4.16.1, v4.15.16, v4.14.33, v4.9.93, v4.4.127.

v4.16.1: Failed to apply! Possible dependencies:
    Unable to calculate

v4.15.16: Failed to apply! Possible dependencies:
    Unable to calculate

v4.14.33: Failed to apply! Possible dependencies:
    Unable to calculate

v4.9.93: Failed to apply! Possible dependencies:
    Unable to calculate

v4.4.127: Failed to apply! Possible dependencies:
    1c4941fd53af ("locking/pvqspinlock: Allow limited lock stealing")
    1f03e8d29192 ("locking/barriers: Replace smp_cond_acquire() with smp_cond_load_acquire()")
    64d816cba06c ("locking/qspinlock: Use _acquire/_release() versions of cmpxchg() & xchg()")


Please let us know if you'd like to have this patch included in a stable tree.

--
Thanks,
Sasha
