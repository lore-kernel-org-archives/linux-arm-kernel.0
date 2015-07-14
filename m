From: olof@lixom.net (Olof Johansson)
Date: Tue, 14 Jul 2015 10:40:04 +0200
Subject: [PATCH 0/2 RESEND] power: reset: Add syscon reboot/poweroff
 device nodes for APM X-Gene platform
In-Reply-To: <1433272747-27114-1-git-send-email-ttnguyen@apm.com>
References: <1433272747-27114-1-git-send-email-ttnguyen@apm.com>
Message-ID: <20150714084004.GA14593@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 12:19:05PM -0700, Tai Nguyen wrote:
> This patch set adds syscon reboot/poweroff device nodes to support reboot and
> poweroff features on X-Gene platform. 
> 
> Tai Nguyen (2):
>   power: reset: Add syscon reboot device node for APM X-Gene platform
>   power: reset: Add syscon poweroff device node for APM X-Gene Mustang platform
> 
>  arch/arm64/boot/dts/apm/apm-mustang.dts |   12 ++++++++++++
>  arch/arm64/boot/dts/apm/apm-storm.dtsi  |   12 ++++++++++++
>  2 files changed, 24 insertions(+)

Hi,

It's unclear to me what you want to happen to these patches. They are
sent to a long list of to-recipients, one of which is arm at kernel.org. In
general, specify the person you want to take action on the patch in to
with the rest on cc.

We generally ask that patches first go to the subarch maintainers,
and they in turn send it on to us (either through a pull request or
by sending the patches to be applied). In the case of X-Gene, there is
no general platform maintainer so we keep getting patches from various
engineers at APM and it's unclear to us what your intentions are.

I'd prefer to see one (to start with) person in charge of these (i.e. one
maintainer from the APM side). Please add that person to the MAINTAINERS
file as well.


Thanks!

-Olof
