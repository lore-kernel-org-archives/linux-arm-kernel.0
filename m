From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 4 Jan 2018 16:41:12 +0900
Subject: [PATCH -next] serial: 8250_uniphier: fix error return code in
 uniphier_uart_probe()
In-Reply-To: <1515051735-59992-1-git-send-email-weiyongjun1@huawei.com>
References: <1515051735-59992-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <CAK7LNASinqpJV+EfL2tKWW5cDMsabMHfCuuC-oARfLLAsQ-rqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-01-04 16:42 GMT+09:00 Wei Yongjun <weiyongjun1@huawei.com>:
> Fix to return a negative error code from the port register error
> handling case instead of 0, as done elsewhere in this function.
>
> Fixes: 39be40ce066d ("serial: 8250_uniphier: fix serial port index in private data")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks!

-- 
Best Regards
Masahiro Yamada
