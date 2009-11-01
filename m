From: davem@davemloft.net (David Miller)
Date: Sun, 01 Nov 2009 02:03:41 -0800 (PST)
Subject: [PATCH] S3C: ide: Add Samsung S3C IDE controller driver
In-Reply-To: <4AED3065.6090808@garzik.org>
References: <1257052029-8406-1-git-send-email-thomas.ab@samsung.com>
	<4AED3065.6090808@garzik.org>
Message-ID: <20091101.020341.22506009.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeff Garzik <jeff@garzik.org>
Date: Sun, 01 Nov 2009 01:53:25 -0500

> On 11/01/2009 01:07 AM, Thomas Abraham wrote:
>> This patch adds Samsung S3C IDE controller driver. This driver
>> supports
>> PIO and UDMA modes of data transfer.
>>
>> Note: This patch depends the following patch series.
>> [PATCH 0/7] S3C64XX: Add platform support for Samsung S3C IDE
>> controller driver
>>
>> Signed-off-by: Abhilash Kesavan<a.kesavan<at>  samsung.com>
>> Signed-off-by: Thomas Abraham<thomas.ab<at>  samsung.com>
> 
> A libata driver would be nice, since we are trying to move away from
> old-IDE.

Yes, I refuse to add new IDE layer drivers to the tree.
