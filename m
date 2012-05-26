From: olof@lixom.net (Olof Johansson)
Date: Sat, 26 May 2012 12:53:34 -0700
Subject: [GIT PULL 4/8] arm-soc: clock driver changes
In-Reply-To: <CA+55aFyAj5GhuNd88AkxUpM72v-ZvvGjgaajD51fS4KHO2ovzg@mail.gmail.com>
References: <1338016958-7887-1-git-send-email-olof@lixom.net>
 <1338016958-7887-5-git-send-email-olof@lixom.net>
 <CA+55aFyAj5GhuNd88AkxUpM72v-ZvvGjgaajD51fS4KHO2ovzg@mail.gmail.com>
Message-ID: <CAOesGMjOH5N4DEOrfyuTK+GLy8i_RNZUz-Cv64c6=99oF=hvgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 26, 2012 at 12:47 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, May 26, 2012 at 12:22 AM, Olof Johansson <olof@lixom.net> wrote:
>>
>> ?151 files changed, 8310 insertions(+), 14192 deletions(-)
>
> Judging by the diffstat, I think we resolved this differently.
>
> I also removed the
>
> ?#include <linux/of.h>
>
> from mach-kirkwood/common.c, since the OF users all got removed. You
> have one less lines deleted than I do, which makes me think you didn't
> remove that header file include.
>
> But I didn't actually check. I thought I'd mention it, just so that it
> doesn't come back (or, assuming I did the wrong thing, you fix it up
> and put it back)

Good catch. Yes, I did indeed keep it and there is no need to do so
since it was only used in the code that got removed. Your resolution
is good. Thanks for the heads up.


Regards,

-Olof
