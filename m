From: carlo@caione.org (Carlo Caione)
Date: Fri, 5 Jun 2015 09:37:49 +0200
Subject: [PATCH v3 0/3] clk: meson: Add clock controller
In-Reply-To: <20150604230717.GE8099@codeaurora.org>
References: <1433157235-17275-1-git-send-email-carlo@caione.org>
 <20150604230717.GE8099@codeaurora.org>
Message-ID: <CAOQ7t2YtMrX9QQHGiCvoPb9SSdvBvzXSu4e7wnzC7eCdUaiWwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 5, 2015 at 1:07 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 06/01, Carlo Caione wrote:
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> This patchset introduces preliminary support for the clock controller
>> found on Amlogic MesonX SoCs and enables it for the Meson8b.
>>
>> DTS patches with support for Meson8b SoCs will follow.
>>
>
> Did you want to send the dts changes through arm-soc?

(adding Arnd in CC) this is what I have done in the past but I have no
strong preference.

> Do they depend on the header file that is included here?

Yes, they do.

> clk-next is not
> stable and shouldn't be pulled into other developer's trees, so
> if we need some stable commit to give off to arm-soc for v4.2
> we need to know soon. Or we can split the header file off into a
> different patch and send it through both arm-soc and clk tree.

Again whatever is more preferable to the maintainers. Just let me know
so I can rearrange the DTS patchset.

> Otherwise the patches look good. I fixed up the __init markings
> on some functions which were in the wrong place.

Thank you,

-- 
Carlo Caione
