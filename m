From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 26 Aug 2011 20:49:05 +0530
Subject: [PATCH v7 03/15] DMA: PL330: Modify device_control()
In-Reply-To: <1314238425-6480-4-git-send-email-boojin.kim@samsung.com>
References: <1314238425-6480-1-git-send-email-boojin.kim@samsung.com>
	<1314238425-6480-4-git-send-email-boojin.kim@samsung.com>
Message-ID: <CABb+yY3s6g3HrfHa9n-WOzhfzi26g46WxzNDCHzEaRg95zSC5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 7:43 AM, Boojin Kim <boojin.kim@samsung.com> wrote:
> This patch modifies device_control() to support both DMA_TERMINATE_ALL
> and DMA_SLAVE_CONFIG command.
> First, modify the flush control for DMA_TERMINATE_ALL command.
> Second, add the slave configuration control for DMA_SLAVE_CONFIG command.

I repeat what I said for v6.
*********
Apart from the alleged purpose "Support DMA_SLAVE_CONFIG command"
this patch also modifies the behavior of DMA_TERMINATE_ALL.
If the change is intended, please split it into two patches and
explain the reason.
Otherwise, restore the behavior.
*********
