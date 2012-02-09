From: olof@lixom.net (Olof Johansson)
Date: Wed, 8 Feb 2012 22:59:25 -0800
Subject: [GIT PULL] mxs/defconfig for 3.4
In-Reply-To: <CAAQ0ZWQzxbQmD__N9zZoE=0N4JX+6XFbFz6CRKannjeBZBLF=A@mail.gmail.com>
References: <20120201154628.GC2203@S2101-09.ap.freescale.net>
 <CAOesGMg5qEXvYDM1BEUj-na69XWE7E6XUWZ1m=pLNwvS8NYwhg@mail.gmail.com>
 <CAAQ0ZWQzxbQmD__N9zZoE=0N4JX+6XFbFz6CRKannjeBZBLF=A@mail.gmail.com>
Message-ID: <CAOesGMiiyQA0EyJcb7-EAQ2-uK35nwR9o3szSJ1eBCrBGcdpFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 8, 2012 at 6:15 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On 8 February 2012 17:14, Olof Johansson <olof@lixom.net> wrote:
> ...
>> Yes, perfectly fine. If you prefer, you can keep your work on a
>> long-lived branch instead of creating new one-off branches for every
>> few patches, and send repeated pull requests for that branch.
>>
> You mean that I can collect all types of patches on a single branch
> like for-arm-soc? ?I'm not sure about that since the platform
> maintainers are asked to send pull-requests sorted in different
> branches for different type of patches. ?Or I'm missing your point?

No, not just in one large branch. But you can collect patches on
specific topics into separate branches that are sent multiple times as
you add patches to it. I.e. similar to how most platform maintainers
have been collecting patches in topic branches with one pull request
done at the end, but with pull requests going in as the branch is
built up.

Does that explanation make sense? I can elaborate if it's still not quite clear.

-Olof
