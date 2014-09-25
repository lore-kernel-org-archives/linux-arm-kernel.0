From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 25 Sep 2014 17:15:51 +0200
Subject: [PATCH] firmware: add Keystone QMSS PDSP accumulator firmware blob
In-Reply-To: <1411654423-29480-1-git-send-email-santosh.shilimkar@ti.com>
References: <1411654423-29480-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20140925151551.GA18530@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 10:13:43AM -0400, Santosh Shilimkar wrote:
> From: Sandeep Nair <sandeep_n@ti.com>
> 
> QMSS(Queue Manager Sub System) uses PDSPs to implement various
> QM related functions like packet accumulation, QoS or event
> management.
> 
> Patch adds firmware blob for the QMSS accumulator
> functionality.
> 
> Cc: Michal Marek <mmarek@suse.cz>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sandeep Nair <sandeep_n@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> I know we are not adding firmware to kernel and the idea is to get them
> loaded via rootfs. But this firmware is for an infrastructure component
> which is needed for Keystone.

What does "infrastructure component" mean?

What is "Keystone"?

> The respective drivers got into the queue
> and the firmware was dropped from the series to follow the firmware tree.

Did you submit this to the linux-firmware tree?

Did the driver that needs this get merged into Linus's tree yet?

thanks,

greg k-h
