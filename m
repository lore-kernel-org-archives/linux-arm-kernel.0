From: ccross@android.com (Colin Cross)
Date: Sun, 20 Feb 2011 23:00:22 -0800
Subject: [PATCH v2 09/21] ARM: tegra: clock: Move unshared clk struct
	members into union
In-Reply-To: <AANLkTi=1Sxsa7ZwUSX6NK2M5Sp3Ww20CumCrividGsrx@mail.gmail.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
	<1298154371-5641-11-git-send-email-ccross@android.com>
	<AANLkTi=1Sxsa7ZwUSX6NK2M5Sp3Ww20CumCrividGsrx@mail.gmail.com>
Message-ID: <AANLkTinzjKd2gT9v73hczQ__35+V5LB7puD8ATuZxJD0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 20, 2011 at 8:10 PM, Olof Johansson <olof@lixom.net> wrote:
> On Sat, Feb 19, 2011 at 2:25 PM, Colin Cross <ccross@android.com> wrote:
>> Signed-off-by: Colin Cross <ccross@android.com>
>
> Same here, short description. With that:
>
> Acked-by: Olof Johansson <olof@lixom.net>
>

I will add:
Creates a union of a struct for each type of clock to reduce memory
usage and clarify which members are used by all clocks and which are
used by a single type.
