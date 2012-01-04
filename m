From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Jan 2012 14:11:26 -0800
Subject: [PATCH] ARM/bcmring: missing sched.h inclusion in dma.c
In-Reply-To: <4F034B56.4060704@broadcom.com>
References: <4F034B56.4060704@broadcom.com>
Message-ID: <CAOesGMiRhB+qQKixPy_HgQjTseSNKYRmfr2AK5VvFgkqA-R3mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 3, 2012 at 10:39 AM, Jiandong Zheng <jdzheng@broadcom.com> wrote:
> Add including of sched.h to fix build error.
>
> This patch was submitted a couple of times last year but unfortunately got
> lost.

What tree is this against? In 3.2-rc7, linux/sched.h is already
included in that file (and the patch doesn't apply cleanly because of
this).


-Olof
