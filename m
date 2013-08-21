From: olof@lixom.net (Olof Johansson)
Date: Tue, 20 Aug 2013 17:31:45 -0700
Subject: [PATCH 05/13] ARM: ux500: Apply a ste-* prefix onto snowball.dts
In-Reply-To: <1374243229-8585-6-git-send-email-lee.jones@linaro.org>
References: <1374243229-8585-1-git-send-email-lee.jones@linaro.org>
 <1374243229-8585-6-git-send-email-lee.jones@linaro.org>
Message-ID: <CAOesGMgd51g7WAkQu+ckT-=skKuMyj19nJkHxh+YmGSBhSL+Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 7:13 AM, Lee Jones <lee.jones@linaro.org> wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/{snowball.dts => ste-snowball.dts} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename arch/arm/boot/dts/{snowball.dts => ste-snowball.dts} (100%)
>
> diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
> similarity index 100%
> rename from arch/arm/boot/dts/snowball.dts
> rename to arch/arm/boot/dts/ste-snowball.dts

Grmbl, grmbl, grmbl. This now breaks any script that knows to use
snowball.dtb. :(

It's good to get the prefixes added, but it's annoying to have to deal
with both during an overlap period. Maybe generate both dtb filenames
for a while but rename the source?


-Olof
