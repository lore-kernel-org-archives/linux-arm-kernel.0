From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 16:17:25 +0100
Subject: [PATCH v1] ARM: multi_v7_defconfig: add driver support for hix5hd2
In-Reply-To: <547891A4.9090405@linaro.org>
References: <1416901046-21091-1-git-send-email-zhangfei.gao@linaro.org>
 <201411281607.48459.arnd@arndb.de> <547891A4.9090405@linaro.org>
Message-ID: <44903559.5EVSLnOq11@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 November 2014 23:15:48 zhangfei wrote:
> On 11/28/2014 11:07 PM, Arnd Bergmann wrote:
> > On Tuesday 25 November 2014, Zhangfei Gao wrote:
> >> Tested on hix5hd2 platform with mmc, usb, network, reboot etc.
> >>
> >> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> >
> > Applied to next/defconfig, thanks!
> >
> > You mentioned earlier that you'd like me to apply this patch so I took it, but
> > you did not send it to arm at kernel.org or ask for it to be applied in the email,
> > so there was still a chance for it to get lost. Please try to be explict
> > about these things as you can.
> >
> 
> Thanks Arnd
> 
> Usually, should this info be listed in the git msg or reply with the 
> original patch?

The best way to do this is to put it under the '---' line that separates
the changelog part of the patch from the additional info like the diffstat.

If you are sending more than one patch at once, use a [PATCH 0/x] introductory
mail and put it in there.

	Arnd
