From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 13 Sep 2012 09:31:39 +0200
Subject: [PATCH 5/7] ARM: OMAP2+: PM debug: trace the functional power
 domains states
In-Reply-To: <874nn2st0m.fsf@deeprootsystems.com>
References: <1347443732-7411-1-git-send-email-j-pihet@ti.com>
 <1347443732-7411-6-git-send-email-j-pihet@ti.com>
 <874nn2st0m.fsf@deeprootsystems.com>
Message-ID: <CAORVsuXMw7dMVZOSk-XSE8_D+qDfuYO3LyXStwC4hARTgb7j4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 1:47 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Use of smp_processor_id() here will require the same care as pointed out
> by Roger Quadros in [PATCH] perf: Use raw_smp_processor_id insted of
> smp_processor_id.
BTW it looks like get_cpu and put_cpu is the way to go, as pointed out
by Russell.

Jean
