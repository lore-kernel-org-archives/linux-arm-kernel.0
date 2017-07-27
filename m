From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 27 Jul 2017 18:12:22 +0100
Subject: [PATCH v8 00/20] ILP32 for ARM64
In-Reply-To: <20170724112624.7ie6na7uszmsc5te@yury-thinkpad>
References: <20170619155003.13218-1-ynorov@caviumnetworks.com>
 <20170629161036.ftedtbp2gdmyzloo@e104818-lin.cambridge.arm.com>
 <20170706215902.qtmbsidwvqlr7o56@yury-thinkpad>
 <20170707171135.h54fe4ea7xuxnrqt@armageddon.cambridge.arm.com>
 <20170724112624.7ie6na7uszmsc5te@yury-thinkpad>
Message-ID: <20170727171221.ep4xs2hhv4pxnhax@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yury,

On Mon, Jul 24, 2017 at 02:26:24PM +0300, Yury Norov wrote:
> On Fri, Jul 07, 2017 at 06:11:36PM +0100, Catalin Marinas wrote:
> > On Fri, Jul 07, 2017 at 12:59:02AM +0300, Yury Norov wrote:
> > > If so, I would like to ask you to do the first ILP32 community poll
> > > now, not in 6 months. So we'll collect opinions and requests from
> > > people interested in ILP32, and in 6 month will be able to check the
> > > progress. I would like to see this thread public because if we are not
> > > taking ILP32 to official sources right now, this is the only way to
> > > inform people that the project exists and is ready to use.
> > 
> > That's an ongoing process, I'm not going to ask for people's opinion
> > every 6 months. It's just that I will revisit periodically the progress
> > on automated testing, public availability of a cross-toolchain,
> > Tested/Acked/Reviewed-by tags on these patches from interested parties.
> > Since I haven't seen any of these now, I don't see any point in asking.
> > 
> > To be clear, I'm not really interested in "we need this too" opinions, I
> > get lots of these via the marketing channels. I'm looking for actual
> > users with a long-term view of making/keeping ILP32 a first class ABI.
> 
> From my side, there are people who ask me for help with ilo32, and who
> write from big companies mailservers. But they don't want to ask
> their questions publicly for some reason. From my point of view, there
> is not so big but stable interest in ILP32.

It would be nice if they were more open about what they need/use.

> This is the 4.12 and linux-next - based kernel patches:
> https://github.com/norov/linux/tree/ilp32-4.12
> https://github.com/norov/linux/tree/ilp32-20170724

Thanks. I'll publish the 4.12-based branch sometime next week.

At this stage I don't see much value in a linux-next based ILP32. I
would rather like to see a 4.13-rc3 based one, in preparation for a 4.13
branch once released.

> Should I resend kernel patches to LKML, or links above are enough for
> you?

The 4.12 link is ok. However, could you please post a 4.13-rcX based
series, maybe split in two so that a few generic patches can be merged
in 4.14? Given the reworking of the sigcontext code in 4.13, it would be
good to review the ILP32 changes in this area again.

Thanks.

-- 
Catalin
