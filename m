From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 09 Jan 2015 19:39:33 +0300
Subject: [PATCH 3/4] MAINTAINERS: Add the RTC driver for the Armada38x
In-Reply-To: <1420817565-28800-4-git-send-email-gregory.clement@free-electrons.com>
References: <1420817565-28800-1-git-send-email-gregory.clement@free-electrons.com>
 <1420817565-28800-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <54B00445.2070000@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 1/9/2015 6:32 PM, Gregory CLEMENT wrote:

> Put it in the mvebu entry.

> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

> diff --git a/MAINTAINERS b/MAINTAINERS
> index ddb9ac8d32b3..49ce80ef3894 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1157,6 +1157,7 @@ M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>   L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
>   F:	arch/arm/mach-mvebu/
> +F:  drivers/rtc/armada38x-rtc

    Please use tab, not spaces after "F:".

WBR, Sergei
