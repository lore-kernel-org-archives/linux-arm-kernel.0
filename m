From: stanislav.meduna@nxtcontrol.com (Stanislav Meduna)
Date: Tue, 19 Apr 2016 20:28:06 +0200
Subject: i.MX53 restart via watchdog does not work
In-Reply-To: <CAOMZO5AxUcjDLo6afdFTkZJv9QnsUvHWwcJmsno3o52DqipN-Q@mail.gmail.com>
References: <57111429.6040802@nxtcontrol.com>
 <CAOMZO5DHTm2iSyGF1CcwuWxzmwbadttKmtVJQePd60A6a0jsgA@mail.gmail.com>
 <571654B0.6040203@nxtcontrol.com>
 <CAOMZO5AxUcjDLo6afdFTkZJv9QnsUvHWwcJmsno3o52DqipN-Q@mail.gmail.com>
Message-ID: <571678B6.4010203@nxtcontrol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/19/2016 8:18 PM, Fabio Estevam wrote:

> I am booting via NFS, so not eMMC related.

Where are you bootstrapping the bootloader from?

I am also not using the eMMC at all, I was tftp-booting
a minimal initramfs image with just rdinit=/bin/sh (the fastest
way to play with reboots).

In my case the bootloader (U-Boot) itself is loaded from
the eMMC. To me it looks the shutdown code somehow brings
the board to a state where the processor itself can't
boot the bootloader.

-- 
                                  Stano
