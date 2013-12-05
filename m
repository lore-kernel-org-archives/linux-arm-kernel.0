From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Dec 2013 15:59:34 +0000
Subject: [PATCH 3/3] arm64: add EFI runtime services
In-Reply-To: <1386258761.1861.137.camel@deneb.redhat.com>
References: <1385762712-17043-1-git-send-email-msalter@redhat.com>
 <1385762712-17043-4-git-send-email-msalter@redhat.com>
 <20131205152510.GB974@darko.cambridge.arm.com>
 <1386258761.1861.137.camel@deneb.redhat.com>
Message-ID: <20131205155934.GA1495@darko.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 03:52:41PM +0000, Mark Salter wrote:
> On Thu, 2013-12-05 at 15:25 +0000, Catalin Marinas wrote:
> > I lost track of the early_ioremap status for arm/arm64? Was there more
> > progress since October (I think)?
> 
> See the two patch series:
> 
>  https://lkml.org/lkml/2013/11/25/474
> 
> and
> 
>  https://lkml.org/lkml/2013/11/27/621
> 
> The latter early_ioremap depends on the first although there are no
> arm64 bits in the first. All of the arm64 early_ioremap stuff is in
> the latter.

Thanks. I was even cc'ed but too many emails in my inbox ;). I'll have a
look.

-- 
Catalin
