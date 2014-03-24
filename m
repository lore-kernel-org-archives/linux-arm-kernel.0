From: chris@printf.net (Chris Ball)
Date: Mon, 24 Mar 2014 13:29:22 +0000
Subject: [PATCH v2 3/4] rename ARCH_BCM to ARCH_BCM_MOBILE (mmc)
In-Reply-To: <20140312214524.GS25092@beef> (Matt Porter's message of "Wed, 12
 Mar 2014 17:45:24 -0400")
References: <1379956836-5866-1-git-send-email-bcm@fixthebug.org>
 <1379956836-5866-4-git-send-email-bcm@fixthebug.org>
 <20140312214524.GS25092@beef>
Message-ID: <86pplbwwr1.fsf@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 12 2014, Matt Porter wrote:
> On Mon, Sep 23, 2013 at 10:20:35AM -0700, Christian Daudt wrote:
>> Currently ARCH_BCM has been used for Broadcom
>> Mobile V7 based SoCs. In order to allow other Broadcom
>> SoCs to also use mach-bcm directory and files, this patch
>> renames the original ARCH_BCM to ARCH_BCM_MOBILE, and
>> uses ARCH_BCM to define any Broadcom chip residing
>> in mach-bcm directory.
>> 
>> Signed-off-by: Christian Daudt <bcm@fixthebug.org>
>> Acked-by: Olof Johansson <olof@lixom.net>
>
> Hi Chris,
>
> Could you please take this patch for 3.15? It was missed for 3.14.

Sorry about that -- it's in mmc-next for 3.15 now.

Thanks,

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
