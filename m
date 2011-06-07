From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 7 Jun 2011 13:39:43 +0530
Subject: [PATCH] ARM:SAMSUNG: Move S3C DMA driver to drivers/dma
In-Reply-To: <BANLkTintADbXSiV07VTMbFfmUV+4-q2-gw@mail.gmail.com>
References: <1307432901-22781-1-git-send-email-alim.akhtar@samsung.com>
	<BANLkTintADbXSiV07VTMbFfmUV+4-q2-gw@mail.gmail.com>
Message-ID: <BANLkTimjWNf3PxHXj3o5qubH5g7gMHjhFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 7, 2011 at 1:30 PM, Kyungmin Park <kmpark@infradead.org> wrote:
>
> As I know there's are PL330 DMA implementation by
> MODULE_AUTHOR("Jaswinder Singh <jassi.brar@samsung.com>");
Thanks for CC'ing me, though my current contact is
jaswinder.singh at linaro.org or jassisinghbrar at gmail.com
Perhaps I need to change the email in all locations.

> Doesn't it better to use the generic PL330 instead of Samsung specific
> PL330 implementation?
Unfortunately, no. There are some features of Samsung's DMA API that
the drivers have come to rely upon.
Besides, I am not particularly a fan of the generic API. And IIRC,
neither is Ben Dooks, the designer of the
Samsung's DMA API.

> As I remember Jassi has a plan to use generic one?
No plans, sorry.

thnx
-j
