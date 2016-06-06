From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 6 Jun 2016 11:59:42 +0100
Subject: [PATCH 0/3] arm64: Kill ESR_LNX_EXEC
In-Reply-To: <20160602182146.GG7697@arm.com>
References: <1464694383-31700-1-git-send-email-mark.rutland@arm.com>
 <20160531165311.GD11321@e104818-lin.cambridge.arm.com>
 <20160602182146.GG7697@arm.com>
Message-ID: <20160606105942.GD6831@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2016 at 07:21:47PM +0100, Will Deacon wrote:
> On Tue, May 31, 2016 at 05:53:11PM +0100, Catalin Marinas wrote:
> > On Tue, May 31, 2016 at 12:33:00PM +0100, Mark Rutland wrote:
> > > Mark Rutland (3):
> > >   arm64: add macro to extract ESR_ELx.EC
> > >   arm64/kvm: use ESR_ELx_EC to extract EC
> > >   arm64: kill ESR_LNX_EXEC
> > 
> > For the series:
> > 
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> You may as well queue this for 4.8 when you start picking up patches.
> I don't think it warrants going in for 4.7, since it doesn't actually
> fix anything.

Makes sense to me.

Catalin, I've dropped this in my git repo for the moment [1], and can
rebase/repost as/when required. Please give me a poke if so.

Thanks,
Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/kill-esr-lnx-exec
