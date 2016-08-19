From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Sat, 20 Aug 2016 01:49:38 +0300
Subject: [PATCH 2/7] ARM: dts: add gpio-ranges property to iMX6Q/D GPIO
 controllers
In-Reply-To: <1471644388-10220-3-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1471644388-10220-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1471644388-10220-3-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <20361341-54d2-1e64-57aa-ce2370d05e9c@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2016 01:06 AM, Vladimir Zapolskiy wrote:
> To establish a connection between GPIO controllers and pin multiplexor
> controller add gpio-ranges properties to all GPIO controllers found
> on iMX50 SoC. The change was done after human parsing of output from

Looks like it is better to update copy-pasted commit messages to
reflect not only imxXX-pinfunc.h file name but also a SoC name from
above.

I expect to get some review comments and fix it all together in v2,
but if you prefer to see better commit messages earlier, please let me
know and I'll resend the edited versions of the changes v1 2-7.

Sorry for a typo.

> % gawk -n '{ sub(/.*__/, ""); if ($1 ~ "^GPIO") print $1, $2/4}' imx6q-pinfunc.h | sort -n
>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---

--
With best wishes,
Vladimir
