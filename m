From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Mar 2014 15:21:53 +0100
Subject: [PATCH 1/4] pinctrl: tegra: fix some typos and inconsistencies
In-Reply-To: <531F3C4E.6040708@wwwdotorg.org>
References: <1394220137-16351-1-git-send-email-swarren@wwwdotorg.org>
 <531F3C4E.6040708@wwwdotorg.org>
Message-ID: <CACRpkda2+hqCF5mojk6qJGj27LGWE2BG55GFo482=GNi0gRGiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 5:39 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 03/07/2014 12:22 PM, Stephen Warren wrote:
>> drive_dev3_pins in pinctrl-tegra114.c wasn't used; delete it.
>>
>> pinctrl-tegra124.c had quite a few typos. Fix those.
>>
>> pinctrl-tegra124.c had a few mismatches between the *_groups[] ararys
>> and the function lists in tegra124_groups[]. Fix those.
>
> Oops. I appear to have sent this first patch separately a couple days
> earlier and accidentally included another identical copy of it in this
> series. This series should have only included patches 2..4.

Hehe no problem, I'll check patches 2 thru 4 and
apply as I go along.

Yours,
Linus Walleij
