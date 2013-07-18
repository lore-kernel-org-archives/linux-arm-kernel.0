From: julien.grall@linaro.org (Julien Grall)
Date: Thu, 18 Jul 2013 18:18:48 +0100
Subject: [PATCH] xen/arm: enable PV control for ARM
In-Reply-To: <alpine.DEB.2.02.1307171435000.8258@kaball.uk.xensource.com>
References: <1373898219-15713-1-git-send-email-julien.grall@linaro.org>
 <alpine.DEB.2.02.1307171435000.8258@kaball.uk.xensource.com>
Message-ID: <CAPnVf8z1YQsRsznag-Z+mnMTu9JxgWptYcDfoswzE-x0aJCDwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 July 2013 14:40, Stefano Stabellini
<stefano.stabellini@eu.citrix.com> wrote:
> On Mon, 15 Jul 2013, Julien Grall wrote:
>> Enable power management from the toolstack for ARM guest.
>>
>> Signed-off-by: Julien Grall <julien.grall@linaro.org>
>
> Considering that now we support both ARM and ARM64, could you please
> add an ifneq ($(CONFIG_ARM64),y) too around cpu_hotplug.o, since you are
> at it?

Yes. I will resend the patch.

-- 
Julien Grall
