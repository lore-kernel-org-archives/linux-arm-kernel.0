From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 11 Mar 2012 00:00:39 -0800
Subject: [GIT PULL] Samsung Cleanup EXYNOS clock for v3.4
In-Reply-To: <20120310173526.GB5972@quad.lixom.net>
References: <4F589474.8050609@samsung.com>
 <CAOesGMiWOChuMjLQTK1pGys+oXCc4A=HO-2_=37rh3M6pgUP_g@mail.gmail.com>
 <4F5A22AD.1070907@samsung.com> <4F5B74C1.3080200@samsung.com>
 <20120310173526.GB5972@quad.lixom.net>
Message-ID: <4F5C5BA7.8050904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/12 09:35, Olof Johansson wrote:

[...]

>
> The contents of the branch itself looks good, but now you have introduced
> a modified/delete conflict with yourself.
>
> You modify arch/arm/mach-exynos/clock.c in your cleanup-use-static branch, and
> then you move it here. That means that when I merge in this branch, git throws
> a conflict and I have to do manual edits to make the contents match.
>
> It's better if you base this branch on your cleanup-use-static branch, so that
> the move includes those edits. That way there is no conflict resolution to do
> at our end either.
>
> Can you please do that rebase and send a fresh pull request? I'll continue
> looking at your other requests meanwhile.
>
Hi Olof,

Sorry for late response. OK I see and your suggestion sounds good to me. 
Let me send a new pull request after that.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
