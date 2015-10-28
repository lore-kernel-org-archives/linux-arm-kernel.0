From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 29 Oct 2015 08:49:12 +0900
Subject: [PATCH] get_maintainer: Add subsystem to reviewer output
In-Reply-To: <1446050506.2757.109.camel@perches.com>
References: <1445960557-24328-1-git-send-email-lee.jones@linaro.org>
 <20151027172428.GB21070@earth> <20151027181555.GE5828@x1>
 <1445971482.2757.27.camel@perches.com>
 <CAJKOXPc_w2Dc8LvkCu_d+kjZZmYScXboQrpNWdicT2yfL_5D7Q@mail.gmail.com>
 <20151028082446.GF5828@x1> <56309419.4060908@samsung.com>
 <20151028093907.GP4931@pengutronix.de> <20151028095524.GP5828@x1>
 <5630CA06.7050503@samsung.com> <1446050506.2757.109.camel@perches.com>
Message-ID: <56315EF8.7030802@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.10.2015 01:41, Joe Perches wrote:
> Reviewer output currently does not include the subsystem
> that matched.  Add it.
> 
> Miscellanea:
> 
> o Add a get_subsystem_name routine to centralize this
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  scripts/get_maintainer.pl | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 

Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
