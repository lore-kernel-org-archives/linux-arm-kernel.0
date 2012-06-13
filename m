From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 13 Jun 2012 14:54:06 +0200
Subject: [RFC 2/4] ARM: topology: factorize the update of sibling masks
In-Reply-To: <1339502524-10265-3-git-send-email-vincent.guittot@linaro.org>
References: <1339502524-10265-1-git-send-email-vincent.guittot@linaro.org>
 <1339502524-10265-3-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1339592046.8980.31.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-06-12 at 14:02 +0200, Vincent Guittot wrote:
> +       smp_wmb();

No cookies for Vince!
