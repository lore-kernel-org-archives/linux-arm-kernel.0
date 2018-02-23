From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Feb 2018 12:59:16 +0000
Subject: Build failure on arm64 defconfig for linux-next recently
In-Reply-To: <0cd1b5a5-820a-3984-01b5-141770adbbea@arm.com>
References: <06af01b0-7d95-35e2-3b21-b54f7ed65efc@rock-chips.com>
 <0cd1b5a5-820a-3984-01b5-141770adbbea@arm.com>
Message-ID: <20180223125916.k2yp7bfes2lrnwrb@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 11:54:19AM +0000, Robin Murphy wrote:
> On 23/02/18 08:03, Shawn Lin wrote:
> > I failed to build the arm64 kernel for linux-20180222 and I confirm it
> > works for linux-20180206. It seems there was some patches for head.S
> > got merged. Is it a known issue? Or a fix is coming?
> 
> Yes, I broke it, sorry!
> 
> There's a fix queued in arm64/fixes/core already (04c4927359b1). Using a
> different toolchain is another option, since the one I'm currently using
> (gcc-linaro-7.2.1-2017.11) builds it just fine, which is how I managed to
> create this mess in the first place ;)

Pull request to go out today. I forgot that arm64 fixes/core doesn't get
pulled into -next (maybe we should fix this).

-- 
Catalin
