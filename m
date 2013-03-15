From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 15 Mar 2013 07:45:20 +0100
Subject: [PATCH 3/3] mfd: ab8500: kill "reg" property from binding
In-Reply-To: <1363298204-8014-3-git-send-email-arnd@arndb.de>
References: <1363298204-8014-1-git-send-email-arnd@arndb.de>
 <1363298204-8014-3-git-send-email-arnd@arndb.de>
Message-ID: <20130315064520.GE12559@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Mar 14, 2013 at 10:56:40PM +0100, Arnd Bergmann wrote:
> The ab8500 device is a child of the prcmu device, which is a memory mapped
> bus device, whose children are addressable using physical memory addresses,
> not using mailboxes, so a mailbox number in the ab8500 node cannot be
> parsed by DT. Nothing uses this number, since it was only introduced
> as part of the failed attempt to clean up prcmu mailbox handling, and
> we can simply remove it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> Please apply to MFD tree for 3.9
Already applied to mfd-fixes.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
