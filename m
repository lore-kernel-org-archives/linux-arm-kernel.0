From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 20 Jan 2017 10:28:12 +0000
Subject: [PATCH] arm: module: add support for R_ARM_REL32 relocations
In-Reply-To: <20170119235642.GK27312@n2100.armlinux.org.uk>
References: <1484863892-5818-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170119235642.GK27312@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu84feSvPtoDg_vCtH+gcL_tZw1GgAYv+uk=vtJ6-OVw9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 January 2017 at 23:56, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Jan 19, 2017 at 10:11:32PM +0000, Ard Biesheuvel wrote:
>> Add support for R_ARM_REL32 relocations in the module loader,
>> which will be used by the modversions code when (if) it switches
>> to using relative references to refer to CRC values.
>
> Thanks, please keep this patch handy for when (if) that does happen.
> I won't apply this until it is actually needed - no point adding stuff
> that never gets used (and therefore doesn't get tested.)
>

Fair enough
