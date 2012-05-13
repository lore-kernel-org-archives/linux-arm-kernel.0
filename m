From: olof@lixom.net (Olof Johansson)
Date: Sun, 13 May 2012 13:18:03 -0700
Subject: [PATCH 0/9] ARM: dt: tegra: cleanup pass
In-Reply-To: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
References: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAOesGMh_adby1fdhoKZ0xovXpAP1nTYOGcDr1DCjZx4yMjR2vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 5:37 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> I've been wanting to clean up the Tegra .dts files for a little while.
> Here's a set of changes to do so. Hopefully they don't seem to much
> like churn.
>
> I was thinking of putting them into a for-3.6/cleanup branch, but I
> suppose I could put them into 3.5 at the end too. I'd need to base this
> series on the result of merging Tegra's for-3.5/dt and
> for-3.5/tegra30-audio branches. Olof, what are your thoughts here?

We could merge it with next/dt2 in arm-soc, so it should be fine. Get
it sent in the next day or two though, please.

> I've tested them on Cardhu so far, but still need to test all the other
> boards to make sure I didn't introduce some typo.

Series generally looks sane, nice cleanup. Overall:

Acked-by: Olof Johansson <olof@lixom.net>
