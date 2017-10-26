From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Thu, 26 Oct 2017 18:56:30 -0400
Subject: [Xen-devel] [PATCH 1/3] arm/xen: don't inclide rwlock.h
 directly.1~B
In-Reply-To: <alpine.DEB.2.10.1710051256230.3073@sstabellini-ThinkPad-X260>
References: <20171005125655.12373-1-bigeasy@linutronix.de>
 <alpine.DEB.2.10.1710051256230.3073@sstabellini-ThinkPad-X260>
Message-ID: <d2550965-8fc6-f9be-8d6e-8cc49a1d1c01@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/2017 03:58 PM, Stefano Stabellini wrote:
> On Thu, 5 Oct 2017, Sebastian Andrzej Siewior wrote:
>> rwlock.h should not be included directly. Instead linux/splinlock.h
>> should be included. One thing it does is to break the RT build.
>>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: xen-devel at lists.xenproject.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


Applied to for-linus-4.14c.

-boris
