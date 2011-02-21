From: ccross@android.com (Colin Cross)
Date: Sun, 20 Feb 2011 22:56:40 -0800
Subject: [PATCH v2 03/21] ARM: tegra: clock: Drop debugging
In-Reply-To: <AANLkTi=MaoEqcOwnsvwWvPsUVFMYXfGsLR6zUbHMQ56R@mail.gmail.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
	<1298154371-5641-5-git-send-email-ccross@android.com>
	<AANLkTi=MaoEqcOwnsvwWvPsUVFMYXfGsLR6zUbHMQ56R@mail.gmail.com>
Message-ID: <AANLkTik+g=42YjLzDgGDifJ4Ci+M2h=h94BRAo++E7DH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 20, 2011 at 8:07 PM, Olof Johansson <olof@lixom.net> wrote:
> On Sat, Feb 19, 2011 at 2:25 PM, Colin Cross <ccross@android.com> wrote:
>> Signed-off-by: Colin Cross <ccross@android.com>
>
> Same here, I know the patch is obvious but just a one-liner in the
> patch description is common practice.
>
> Acked-by: Olof Johansson <olof@lixom.net>

I will add:
Drop the unnecessary pr_debug calls to avoid having to maintain them.
