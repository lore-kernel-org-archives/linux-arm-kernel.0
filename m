From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 26 Apr 2013 00:38:56 +0900
Subject: [GIT PULL] Late Exynos stuff for v3.10
In-Reply-To: <20130424000638.GA9067@quad.lixom.net>
References: <5176B499.1000208@samsung.com> <51770697.7080504@samsung.com>
 <20130424000638.GA9067@quad.lixom.net>
Message-ID: <51794E10.1010205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/13 09:06, Olof Johansson wrote:
> Hi,
>
Hi Olof,

> Can I please ask you to make our life a little easier by telling us what the
> specific problems these patches solve are? What I am looking for is something
> along the lines of:
>
> --
>
> This branch includes some last-minute enablements of DT contents for features
> that are queued for 3.10:
>   - USB PHY drivers on Exynos 5250
>   - MMC (mshc) on Exynos 4x12
>   - XCHI (USB 3.0) on Exynos 5250
>
> It also contains a fix to disable RTC on exynos [because ... you fill in this
> part].
>
> --
>
> It doesn't have to be something super-elaborate, but I'd like it to be sort of
> self-documenting in a way that I don't have to look through the series of
> patches to get an overview of what's in the branch. Of course we'll also do
> that to review the code, but having the description there makes things easier
> for us to tell if we should even be looking at it, etc.
>
>
OK, I see. Let me do it more carefully.

And let me send pull-request again for fix and late dt branch with 
separated branches in a couple of hours not including usb stuff...

Thanks.

- Kukjin
