From: jeff@garzik.org (Jeff Garzik)
Date: Fri, 14 May 2010 13:42:14 -0400
Subject: [PATCH] PXA DMA-capable PATA driver
In-Reply-To: <201005141551.55066.marek.vasut@gmail.com>
References: <1273460525-25662-1-git-send-email-marek.vasut@gmail.com>
	<201005141551.55066.marek.vasut@gmail.com>
Message-ID: <4BED8B76.5010701@garzik.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2010 09:51 AM, Marek Vasut wrote:
> Dne Po 10. kv?tna 2010 05:02:05 Marek Vasut napsal(a):
>> This patch adds a driver for a harddrive attached to PXA address and data
>> bus. Unlike pata_platform, this driver allows usage of PXA DMA controller,
>> making the transmission speed 3x higher.
>>
>> Signed-off-by: Marek Vasut<marek.vasut@gmail.com>
>
> Hey, any updates on this ?

It's queued for #upstream review, should get merged today or tomorrow.

Typically I wait a while, for comments from PATA-interested folks.

	Jeff
