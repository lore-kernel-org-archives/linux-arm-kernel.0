From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 09 Mar 2011 11:29:06 -0800
Subject: [PATCH 0/4] SCM fixes and updates
In-Reply-To: <1298573085-23217-1-git-send-email-sboyd@codeaurora.org>
References: <1298573085-23217-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <4D77D502.1090606@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2011 10:44 AM, Stephen Boyd wrote:
> These are a few updates to SCM. The first two patches fix some
> bad code generation. The next patch saves a couple instructions
> on the slow path and the final patch determines the cacheline
> size dynamically instead of statically.
>
> Stephen Boyd (4):
>   msm: scm: Mark inline asm as volatile
>   msm: scm: Fix improper register assignment
>   msm: scm: Check for interruption immediately
>   msm: scm: Get cacheline size from CTR
>

Can we queue up patches 1 to 3 from this series for the next window? It
looks like everyone is ok with them. I'll respin the fourth patch once I
figure out where to go with it.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
