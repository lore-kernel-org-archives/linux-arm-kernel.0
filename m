From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Sep 2016 19:11:46 +0100
Subject: [PATCH v2 1/2] jump_labels: Allow array initialisers
In-Reply-To: <1473096348-19548-2-git-send-email-catalin.marinas@arm.com>
References: <1473096348-19548-1-git-send-email-catalin.marinas@arm.com>
 <1473096348-19548-2-git-send-email-catalin.marinas@arm.com>
Message-ID: <20160906181146.GD29382@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 06:25:47PM +0100, Catalin Marinas wrote:
> The static key API is currently designed around single variable
> definitions. There are cases where an array of static keys is desirable,
> so extend the API to allow this rather than using the internal static
> key implementation directly.
> 
> Suggested-by: Dave P Martin <Dave.Martin@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jason Baron <jbaron@akamai.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  Documentation/static-keys.txt |  9 +++++++++
>  include/linux/jump_label.h    | 12 ++++++++++++
>  2 files changed, 21 insertions(+)

This looks pretty straightforward to me, and I'd like to take it via
the arm64 tree given that your subsequent patch depends on it.

Peter -- are you ok with this?

Cheers,

Will
