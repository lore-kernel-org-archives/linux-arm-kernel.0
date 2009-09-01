From: risingsunxy@googlemail.com (Xu Yang)
Date: Tue, 1 Sep 2009 11:29:11 +0200
Subject: arm linux porting effort
In-Reply-To: <4A9CE50D.40905@googlemail.com>
References: <ab40e9c0909010154i3cf6e51duf155fd3ca04ff92@mail.gmail.com>
	<4A9CE50D.40905@googlemail.com>
Message-ID: <ab40e9c0909010229y3aa6e149v5db94ba90ff972b9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Dirk,

thanks a lot for your good advice.

I will look at this and try:-)

Best regards,

Yang

2009/9/1, Dirk Behme <dirk.behme@googlemail.com>:
> Xu Yang wrote:
> > hi guys,
> >
> > we already have linux kernel 2.6.29 running on our own arm1176
> > platform. now I would like to upgrade the kernel to 2.6.30(or we can
> > say to port 2.6.30 on our platform). I haven't done this before, so I
> > don't know how much effort this means.
> >
> > anyone any ideas? or any hints?
> >
>
> From 2.6.29 to 2.6.30 you could try to let git do the work. Try to git merge
> (or rebase?), resolve the conflicts, build, boot and check if everything is
> still working. If you create an extra branch for this, you will break
> nothing and will know the effort afterwards ;)
>
> Best regards
>
> Dirk
>
