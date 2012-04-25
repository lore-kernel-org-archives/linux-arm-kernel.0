From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 24 Apr 2012 17:32:37 -0700
Subject: [GIT PULL] Samsung fixes-2 for v3.4
In-Reply-To: <CAOesGMhp48Kh+tJ1534G=ze0CEcVBpaPQxVKs8A31difVw9h9Q@mail.gmail.com>
References: <4F89A0A5.5030806@samsung.com>
 <CAOesGMhp48Kh+tJ1534G=ze0CEcVBpaPQxVKs8A31difVw9h9Q@mail.gmail.com>
Message-ID: <4F974625.1030607@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> Hi,

[...]

(Cc'ed Marek Szyprowsk)

> Looking at your current fixes-3 branch, it's unclear at a quick glance
> why the clk_type patch is a bugfix, and especially why it is a
> regression fix -- it looks like a cleanup. We're very close to 3.4-rc3

I agree that the removing clk_type member in sdhci platform data should 
be included in cleanup stuff, it is useless in current mainline though.

Marek, is this ok to you?

> now, so we should only be merging fixes (and ideally only regressions
> since 3.3).
>
> So, if you do need it to go into 3.4 please motivate it when you send
> the pull request.
>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
