From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 4 Aug 2012 09:30:42 +0800
Subject: [PATCH v3 2/9] MMC: pxa-mci: add DT bindings
In-Reply-To: <87k3xf354c.fsf@octavius.laptop.org>
References: <1343470061-16879-1-git-send-email-zonque@gmail.com>
 <1343470061-16879-3-git-send-email-zonque@gmail.com>
 <87k3xf354c.fsf@octavius.laptop.org>
Message-ID: <CAN1soZxwBh4wR5C-x0bsj5U_wY6gF50uo=xo5HADS+PuXptCXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 4, 2012 at 7:52 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Sat, Jul 28 2012, Daniel Mack wrote:
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> Cc: Nicolas Pitre <nico@fluxnic.net>
>> Cc: Chris Ball <cjb@laptop.org>
>> ---
>>  Documentation/devicetree/bindings/mmc/pxa-mmc.txt | 25 +++++++++++
>>  drivers/mmc/host/pxamci.c                         | 52 +++++++++++++++++++++++
>>  2 files changed, 77 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/pxa-mmc.txt
>
> Mind if I merge this via the MMC tree?  I prefer to take MMC patches
> there, and it doesn't look like there are any dependencies involved.
> I've pushed it to mmc-next now.
>

There's no problem of your merging. I'll revert it in pxa git tree.

Regards
Haojian
