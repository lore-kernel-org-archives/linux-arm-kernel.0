From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sat, 7 Jan 2017 23:37:06 +0530
Subject: [PATCH WIP 4/4] ARM: remove compile time vector base for CP15 case
In-Reply-To: <20170107180227.GA8130@afzalpc>
References: <20170107171339.GA5044@afzalpc>
 <20170107172228.6451-1-afzal.mohd.ma@gmail.com>
 <20170107173832.GN14217@n2100.armlinux.org.uk>
 <20170107180227.GA8130@afzalpc>
Message-ID: <20170107180706.GA8525@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jan 07, 2017 at 11:32:27PM +0530, Afzal Mohammed wrote:

> i had thought that for MMU case if Hivecs is not enabled,
> CONFIG_VECTOR_BASE has to be considered as 0x00000000 at least for the

s/CONFIG_VECTOR_BASE/exception base address

> purpose of displaying exception base address.

Regards
afzal
