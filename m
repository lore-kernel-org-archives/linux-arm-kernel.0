From: anish198519851985@gmail.com (anish singh)
Date: Sun, 10 Apr 2011 09:03:49 +0530
Subject: [PATCH v2 00/12] mmc: use nonblock mmc requests to minimize
	latency
In-Reply-To: <BANLkTikVeXvfSBS-xLDXVdesKJpKdtUVqg@mail.gmail.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<BANLkTikZVDejarZ4O5KgNS7S4fxBLSmANA@mail.gmail.com>
	<BANLkTikVeXvfSBS-xLDXVdesKJpKdtUVqg@mail.gmail.com>
Message-ID: <BANLkTikwCveocjPdoMoLEVpNneKkq66s4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 9, 2011 at 5:25 PM, Jae hoon Chung <jh80.chung@gmail.com> wrote:

> Hi Per..
>
> I'm applied your patch..and sent the patch about dw_mmc.c.
> I think good this approach..
>
Forlin,i too want to test this patch of yours but unfortunately i have
samsung board+SDHCI host controller so i guess i just need to write pre_req
and post_req functions and that would enable this(nonblock mmc request) on
my board.Hope i am right?

>
> Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
>
> Regards,
> Jaehoon Chung
>
> 2011/4/9 Linus Walleij <linus.walleij@linaro.org>:
> > On Wed, Apr 6, 2011 at 9:07 PM, Per Forlin <per.forlin@linaro.org>
> wrote:
> >
> >> The intention for introducing none blocking mmc requests is to minimize
> the
> >> time between a mmc request ends and another mmc request starts.
> >
> > Acked-by: Linus Walleij <linus.walleij@linaro.org> FWIW, I've looked at
> the
> > patches so many times I'm already blind for any remaining bugs...
> >
> > Yours,
> > Linus Walleij
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>  > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110410/713621b5/attachment-0001.html>
