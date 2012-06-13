From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 13 Jun 2012 14:52:49 +0200
Subject: [RFC 1/4] ARM: topology: Add arch_scale_freq_power function
In-Reply-To: <1339502524-10265-2-git-send-email-vincent.guittot@linaro.org>
References: <1339502524-10265-1-git-send-email-vincent.guittot@linaro.org>
 <1339502524-10265-2-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1339591969.8980.30.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-06-12 at 14:02 +0200, Vincent Guittot wrote:
>         }
>         smp_wmb();
>  } 

You know what.. we should make checkpatch report an error for memory
barriers that don't have a comment. 

I know this isn't added by this patch, but every time I see something
like it I cry a little.
