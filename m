From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Nov 2009 16:53:01 +0000
Subject: [PATCH 00/20] iPAQ h3100/h3600 work for 2.6.33
In-Reply-To: <20091124212541.GA5751@rainbow>
References: <1256414658-22611-1-git-send-email-mad_soft@inbox.ru>
	<20091024211026.GE16451@n2100.arm.linux.org.uk>
	<20091025153603.GA24490@rainbow> <20091115173048.GA19609@rainbow>
	<20091123203931.GI18142@n2100.arm.linux.org.uk>
	<20091124212541.GA5751@rainbow>
Message-ID: <20091125165301.GC5136@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 12:25:41AM +0300, Dmitry Artamonow wrote:
> Oh, and forgot to mention - your 'sa1100' branch is currently based on
> 2.6.32-rc3, you'll need to rebase it on more current -rc before applying
> my patches, because of 4918a0139 (ARM: 5752/1: SA1100: fix building of
> h3100), which went in -rc4.

Ok, sa1100 rebased; please submit your patch series to the patch system,
or alternatively if you have a git tree, base it off my sa1100 branch
and I'll pull that instead.
