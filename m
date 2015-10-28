From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 28 Oct 2015 17:57:05 +0900
Subject: [PATCH] MAINTAINERS: Start using the 'reviewer' (R) tag
In-Reply-To: <1445960557-24328-1-git-send-email-lee.jones@linaro.org>
References: <1445960557-24328-1-git-send-email-lee.jones@linaro.org>
Message-ID: <56308DE1.9030303@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On 2015? 10? 28? 00:42, Lee Jones wrote:
> Since eafbaac ("MAINTAINERS: Add "R:" designated-reviewers tag") we
> have been able to tag specific people as Reviewers.  These are key
> individuals who are tasked with or volunteer to review code submitted
> to a subsystem or specific file.  However, according to MAINTAINERS
> we have 1046 Maintainers and only a mere 22 Reviewers.  I believe
> these numbers to be incorrect, as many of these Maintainers are in
> fact Reviewers.
> 
> I have taken the time to identify some of the Reviewers who pertain
> to subsystems which I look after, and have changed their status from
> Maintainer (collector of patches) to Reviewer (reviewer of code).
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
>  MAINTAINERS | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Although this patch don't include the entry of drivers/extcon,
I agree your opinion to add 'R' for Reviewer.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
