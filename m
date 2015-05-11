From: ttnguyen@apm.com (Tai Tri Nguyen)
Date: Mon, 11 May 2015 12:15:06 -0700
Subject: [PATCH 0/2] power: reset: Add syscon reboot/poweroff device nodes
 for APM X-Gene platform
In-Reply-To: <1430511074-32229-1-git-send-email-ttnguyen@apm.com>
References: <1430511074-32229-1-git-send-email-ttnguyen@apm.com>
Message-ID: <CACgAJHzxVjg+m+4swXwyGGGf43WkJmxxGOJnXnwA=TwKmJCWTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Any comment on these patches, please?

Thanks,
Tai


On Fri, May 1, 2015 at 1:11 PM, Tai Nguyen <ttnguyen@apm.com> wrote:
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
>
> --
> 1.7.9.5
>



-- 
Tai
