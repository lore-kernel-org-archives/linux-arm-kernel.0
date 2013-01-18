From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 17 Jan 2013 19:33:34 -0800
Subject: [PATCH v2] arch/arm/mach-s5pv210: adding ifdef
 CONFIG_CPU_S5PV210to fix compiling issue
In-Reply-To: <20130118011846.3CEE21840258@intranet.asianux.com>
References: <001c01cdf510$c89c9800$59d5c800$@samsung.com>
 <20130118011846.3CEE21840258@intranet.asianux.com>
Message-ID: <009801cdf52c$99adc200$cd094600$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chen,Gang( ??) wrote:
> 
> 
> > For subject:
> > Please see the git log before your commit, it should be helpful to you.
> > In this case, 'ARM: S5PV210: ...' is used.
> 
>   thank you, I should notice it next time.
>     an incorrect subject is not easy to get maintainer's notice
>     maybe it is the reason why you can not reply in time, since you can not notice it.
> 
>   :-)
> 
Just I was busy ;-) sorry for late my reply.

Anyway Gang, don't post with html typed e-mail, probably, you got some kind of error that your previous reply wasn't accepted from mailing list mail server. Please make sure that your e-mail is plain text type for mailing list.

[...]

> > I don't think so, because common.c in mach-s5pv210 should be built with
> > selecting CONFIG_CPU_S5PV210, actually it depends on CONFIG_ARCH_S5PV210
> > though.
> > 
> > Any concerns, please let me know.
> 
>   ok, thank you.
>   and
>     is it suitable to delete the reletive code of  " define NULL in common.h for s5pv210_* "  ?
>     it seems they are wast.
> 
Yes, right. We don't need more that.  I missed it when I introduced common.[ch] local at the commit 3fa754c2. Thanks for pointing out and I will sort out.

[...]

Thanks.

- Kukjin
