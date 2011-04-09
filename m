From: jh80.chung@gmail.com (Jae hoon Chung)
Date: Sat, 9 Apr 2011 20:55:16 +0900
Subject: [PATCH v2 00/12] mmc: use nonblock mmc requests to minimize
	latency
In-Reply-To: <BANLkTikZVDejarZ4O5KgNS7S4fxBLSmANA@mail.gmail.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<BANLkTikZVDejarZ4O5KgNS7S4fxBLSmANA@mail.gmail.com>
Message-ID: <BANLkTikVeXvfSBS-xLDXVdesKJpKdtUVqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Per..

I'm applied your patch..and sent the patch about dw_mmc.c.
I think good this approach..

Tested-by: Jaehoon Chung <jh80.chung@samsung.com>

Regards,
Jaehoon Chung

2011/4/9 Linus Walleij <linus.walleij@linaro.org>:
> On Wed, Apr 6, 2011 at 9:07 PM, Per Forlin <per.forlin@linaro.org> wrote:
>
>> The intention for introducing none blocking mmc requests is to minimize the
>> time between a mmc request ends and another mmc request starts.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org> FWIW, I've looked at the
> patches so many times I'm already blind for any remaining bugs...
>
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
