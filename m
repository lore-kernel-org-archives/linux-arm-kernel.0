From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 23 Jan 2013 11:27:46 +0000
Subject: [PATCH 8/8] ARM: ux500: Remove traces of the ios_handler from
 platform code
In-Reply-To: <CACRpkdZnDi8F7Zu646CPEt9SAx5gA=v0CJ-Rq1eJqKS_s2EHvw@mail.gmail.com>
References: <1355404930-5691-1-git-send-email-lee.jones@linaro.org>
 <1355404930-5691-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdbwQAEQxWpXHoEieou5rShcZvsGSddKLaOjwGeG-2o=wg@mail.gmail.com>
 <CACRpkdZnDi8F7Zu646CPEt9SAx5gA=v0CJ-Rq1eJqKS_s2EHvw@mail.gmail.com>
Message-ID: <20130123112746.GJ15873@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Jan 2013, Linus Walleij wrote:

> On Wed, Jan 23, 2013 at 11:04 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
> > On Thu, Dec 13, 2012 at 2:22 PM, Lee Jones <lee.jones@linaro.org> wrote:
> >
> >> Now MMCI on/off functionality is using the regulator framework
> >> from the MMCI driver, there is no need to keep the ios_handler
> >> laying around, duplicating functionality. So we're removing it.
> >>
> >> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >
> > Applied to my ux500-cleanups branch.
> 
> Or no, wait, that is dependent or Russell's tree so will not
> be bisectable.
> 
> Either submit sequel patches to [1/8] through Russell's
> patch tracker (based on his tree I guess) or wait for these
> to hit mainline and push them after that.
> 
> Acked-by anway, on all of the cleanups following [1/8].

I have this queued already, with the MMCI patch in as a dependency.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
