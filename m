From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Jan 2012 14:12:02 -0800
Subject: [PATCH] ARM/bcmring: fix build error with sp804 clockevents init
In-Reply-To: <4F034B28.10706@broadcom.com>
References: <4F034B28.10706@broadcom.com>
Message-ID: <CAOesGMj1Jv0AqUHHovYLvDTWuz2Xp4UGZGmPxzzFpHd-cM83VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 3, 2012 at 10:38 AM, Jiandong Zheng <jdzheng@broadcom.com> wrote:
> Wrong API sp804_clockevents_register() was used and caused build error.
> So change to use sp804_clockevents_init().
>
> This patch was submitted a couple of times last year but unfortunately got
> lost.

Same with this patch as with the dma.c one: It's already fixed in
mainline top of tree. What tree are you working against?


-Olof
