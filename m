From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Aug 2017 15:50:31 +0100
Subject: [PATCH 0/5] Simplify kernel-mode NEON
In-Reply-To: <20170804142505.GM6321@e103592.cambridge.arm.com>
References: <1501777403-9782-1-git-send-email-Dave.Martin@arm.com>
 <20170804120858.ff3772f3zzik37pp@armageddon.cambridge.arm.com>
 <20170804122225.jiceb2vbgrld2y7z@armageddon.cambridge.arm.com>
 <CAKv+Gu-YG1EbpvaL46T0fzD=RZ7itqizrH=AkYAN1YmTupmKGw@mail.gmail.com>
 <20170804131211.2wn2zi74kuzuwneo@armageddon.cambridge.arm.com>
 <CAKv+Gu_va4hD-MztzRUhXxTwqnbKcmOmV8NN9j+TG8_jWA0wNA@mail.gmail.com>
 <20170804132606.GQ989@e103592.cambridge.arm.com>
 <20170804140526.cu3ojheqomsxzyjb@armageddon.cambridge.arm.com>
 <20170804142505.GM6321@e103592.cambridge.arm.com>
Message-ID: <20170804145030.7dun77kcwjdfal23@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 04, 2017 at 03:25:05PM +0100, Dave P Martin wrote:
> On Fri, Aug 04, 2017 at 03:05:26PM +0100, Catalin Marinas wrote:
> > On Fri, Aug 04, 2017 at 02:26:06PM +0100, Dave P Martin wrote:
> > > On Fri, Aug 04, 2017 at 02:21:52PM +0100, Ard Biesheuvel wrote:
> 
> [...]
> 
> > > > >> On 4 August 2017 at 13:22, Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> [...]
> 
> > > > >> > ... and reverted.
> 
> [...]
> 
> > > > Perhaps we could stick it on a separate branch for this cycle (with
> > > > the suggested tweak) and get it pulled it into -next separately? That
> > > > way, you can forward it as a late pull, after Herbert's stuff gets in.
> > > 
> > > Or I could prepend the patches to the SVE series, and we wait for Linux
> > > to pull the crypto branch before merging that.  (I still need to repost
> > > and the SVE patches need to be reviewed, so that isn't imminent.)
> > 
> > I'll publish a branch early next week with the kernel mode neon patches
> > and you can base the SVE on top. We can test them together but I'll
> > wait for the crypto stuff to go in before sending this branch to Linus.
> 
> OK, this sounds like a good approach.
> 
> Ping me when you have a branch, but anyway I'll drop those patches from
> the SVE series.

Here it is:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/kernel-mode-neon

-- 
Catalin
