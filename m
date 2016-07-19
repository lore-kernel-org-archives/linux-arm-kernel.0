From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jul 2016 15:31:41 +0100
Subject: [PATCH 0/2] arm/arm64: localise objcopy flags
In-Reply-To: <20160719102925.GB27022@leverpostej>
References: <1468337282-14527-1-git-send-email-mark.rutland@arm.com>
 <a1441405-5a3a-731c-2693-b66cd42edc99@redhat.com>
 <20160719102925.GB27022@leverpostej>
Message-ID: <20160719143141.GF21256@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 11:29:26AM +0100, Mark Rutland wrote:
> On Mon, Jul 18, 2016 at 04:16:34PM -0700, Laura Abbott wrote:
> > On 07/12/2016 08:28 AM, Mark Rutland wrote:
> > >Mark Rutland (2):
> > >  arm64: localise Image objcopy flags
> > >  arm: localise objcopy flags
> > >
> > > arch/arm/Makefile        | 1 -
> > > arch/arm/boot/Makefile   | 2 ++
> > > arch/arm64/Makefile      | 1 -
> > > arch/arm64/boot/Makefile | 2 ++
> > > 4 files changed, 4 insertions(+), 2 deletions(-)
> > >
> > 
> > Kees' lkdtm tests compile and boot successfully with this patch for
> > both arm and arm64 so you can add
> > 
> > Tested-by: Laura Abbott <labbott@redhat.com>
> 
> Cheers!
> 
> On the assumption that Russell is ok with the arm patch, I've dropped
> that in the patch system (with tags) as 8588/1 [1].
> 
> Catalin, Will, I guess I should repost the arm64 patch come v4.8-rc1?

I queued them for 4.8. Thanks.

-- 
Catalin
