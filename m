From: bcm@fixthebug.org (Christian Daudt)
Date: Fri, 13 Dec 2013 08:43:46 -0800
Subject: [PATCH v2 2/4] rename ARCH_BCM to ARCH_BCM_MOBILE (clocksource)
In-Reply-To: <52AAC9E1.6070405@linaro.org>
References: <1379956836-5866-1-git-send-email-bcm@fixthebug.org>
 <1379956836-5866-3-git-send-email-bcm@fixthebug.org>
 <52AAC9E1.6070405@linaro.org>
Message-ID: <CAEPRUYpxrhsif-OWi+mcbwbp1V7=8H250Fvx5McbGqifRzh8rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 12:48 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 09/23/2013 07:20 PM, Christian Daudt wrote:
>>
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
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>

Thanks. I've applied it to armsoc/for-3.14/soc


 csd
