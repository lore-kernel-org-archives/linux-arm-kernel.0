From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 27 Jan 2014 18:35:57 +0100
Subject: [PATCH 1/9] ARM: get rid of arch_cpu_idle_prepare()
In-Reply-To: <20140127172110.GR15937@n2100.arm.linux.org.uk>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-2-git-send-email-nicolas.pitre@linaro.org>
 <52E6175F.1050401@linaro.org>
 <20140127160736.GP15937@n2100.arm.linux.org.uk>
 <52E69395.9020004@linaro.org>
 <20140127172110.GR15937@n2100.arm.linux.org.uk>
Message-ID: <20140127173557.GE4941@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 05:21:10PM +0000, Russell King - ARM Linux wrote:
> A reviewed-by tag on its own doesn't mean much, as it could mean that
> you've just glanced over the code and decided "yea, it looks okay", or
> it could mean that you've spent all day verifying that the code change
> is indeed correct.

One should use Acked-by for the 'yea, it looks okay' thing.
