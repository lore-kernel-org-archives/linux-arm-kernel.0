From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 10 Apr 2012 22:12:06 +0530
Subject: [PATCH 3/4] arm: davinci: use for_each_set_bit_from
In-Reply-To: <1333442836-9947-3-git-send-email-akinobu.mita@gmail.com>
References: <1333442836-9947-1-git-send-email-akinobu.mita@gmail.com>
 <1333442836-9947-3-git-send-email-akinobu.mita@gmail.com>
Message-ID: <4F8462DE.4030004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akinobu,

On 4/3/2012 2:17 PM, Akinobu Mita wrote:
> Use for_each_set_bit_from to iterate over all the set bit in a memory
> region.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org

Looks good to me. If you are planning to send this upstream outside of
davinci tree, please add my:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Else, let me know and I will be happy to queue it.

Thanks,
Sekhar
