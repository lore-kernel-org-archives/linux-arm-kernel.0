From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Wed, 7 Sep 2011 11:03:58 +0530
Subject: [PATCH v6 20/25] gpio/omap: skip operations in runtime callbacks
In-Reply-To: <87ty8pw7jm.fsf@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-21-git-send-email-tarun.kanti@ti.com>
	<87ty8pw7jm.fsf@ti.com>
Message-ID: <CAC83Zv+OoysGwzGqydFkCd6y4aRr-67LUcpMBfyuZiYqkhJzOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 7, 2011 at 5:24 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> Most operations within runtime callbacks should be skipped when
>> *_runtime_get_sync() and *_runtime_put_sync() are called in probe(),
>> *_gpio_request() and *_gpio_free().
>
> Why?
>
> (again, I know the answer, but should be described in the changelog for
> folks not familiar with this driver, or when we come back to this in 3
> months and have forgotten why.
Ok.

>
>> We just need clock enable/disable.
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Kevin
>
