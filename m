From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Apr 2016 15:43:31 -0300
Subject: i.MX53 restart via watchdog does not work
In-Reply-To: <571678B6.4010203@nxtcontrol.com>
References: <57111429.6040802@nxtcontrol.com>
 <CAOMZO5DHTm2iSyGF1CcwuWxzmwbadttKmtVJQePd60A6a0jsgA@mail.gmail.com>
 <571654B0.6040203@nxtcontrol.com>
 <CAOMZO5AxUcjDLo6afdFTkZJv9QnsUvHWwcJmsno3o52DqipN-Q@mail.gmail.com>
 <571678B6.4010203@nxtcontrol.com>
Message-ID: <CAOMZO5AUWDwdui+zkAxUu=m2XcOcrrtFEpib0oj+p_QokSR-bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 3:28 PM, Stanislav Meduna
<stanislav.meduna@nxtcontrol.com> wrote:
> On 4/19/2016 8:18 PM, Fabio Estevam wrote:
>
>> I am booting via NFS, so not eMMC related.
>
> Where are you bootstrapping the bootloader from?
>
> I am also not using the eMMC at all, I was tftp-booting
> a minimal initramfs image with just rdinit=/bin/sh (the fastest
> way to play with reboots).
>
> In my case the bootloader (U-Boot) itself is loaded from
> the eMMC. To me it looks the shutdown code somehow brings
> the board to a state where the processor itself can't
> boot the bootloader.

imx53-qsb boots from a SD card. Issuing a 'reboot' command works fine
on 4.6-rc4.
