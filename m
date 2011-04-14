From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Thu, 14 Apr 2011 13:40:25 +0900
Subject: [PATCH 3/4] ARM: EXYNOS4: Add usb ehci device to the NURI board
In-Reply-To: <20110413235402.GA32159@kroah.com>
References: <1302236532-27636-1-git-send-email-jy0922.shim@samsung.com>
	<1302236532-27636-3-git-send-email-jy0922.shim@samsung.com>
	<20110413235402.GA32159@kroah.com>
Message-ID: <4DA67AB9.2080107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2011-04-14 ?? 8:54, Greg KH wrote:
> On Fri, Apr 08, 2011 at 01:22:11PM +0900, Joonyoung Shim wrote:
>> This patch is to support usb ehci device to the NURI board.
>>
>> Signed-off-by: Joonyoung Shim<jy0922.shim@samsung.com>
>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
>
> Note, I had to apply this one by hand, I don't know what tree you made
> it against.  Hopefully the merge issues will be simple to handle, as
> they were pretty obvious to me.
>

This patch is based from for-next branch of linux-samsung tree
(git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git),
so will occur merge conflict at the your usb tree.

Sorry for missing about tree.
