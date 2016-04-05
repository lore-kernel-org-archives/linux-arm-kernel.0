From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 5 Apr 2016 10:15:24 +0800
Subject: [v14, 01/17] drm: bridge: analogix/dp: split exynos dp driver to
 bridge directory
In-Reply-To: <CAD=FV=VqWqtraAbMTN-Qn7gEOgLmrsXRAeRtxtB0qRj84JREeA@mail.gmail.com>
References: <1455534576-1486-1-git-send-email-ykk@rock-chips.com>
 <20160330203204.GA24156@roeck-us.net>
 <20160331095600.GD26032@ulmo.nvidia.com>
 <CAD=FV=VqWqtraAbMTN-Qn7gEOgLmrsXRAeRtxtB0qRj84JREeA@mail.gmail.com>
Message-ID: <57031FBC.5000904@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 04/01/2016 12:02 AM, Doug Anderson wrote:
> Hi,
>
> On Thu, Mar 31, 2016 at 2:56 AM, Thierry Reding <treding@nvidia.com> wrote:
>> Ugh... most of these functions shouldn't be there in the first place. We
>> have helpers in the core that already do this. Most of the functionality
>> is duplicated in this driver.
>>
>> I realize that this is a problem that existed in the Exynos DP driver,
>> but somebody really ought to rewrite those parts to make use of the DRM
>> DP helpers.
> As I understand it from discussions in
> <http://article.gmane.org/gmane.linux.drivers.devicetree/162059> and
> <http://article.gmane.org/gmane.linux.kernel.samsung-soc/53048>, we
> shouldn't block merging the series but someone should pick up this
> work after the merge.
>
> So probably Yakir should fixup the problem pointed out by Guenter and
> send a new pull.
Yep, should I just update the pull request. Or I should send v15 first
and then update the pull request ?

- Yakir
> -Doug
>
>
>
