From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Nov 2018 00:51:09 +0000
Subject: [PATCH v9 00/24] ILP32 for ARM64
In-Reply-To: <20181113105717.GA5664@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180724173957.GA22106@yury-thinkpad> <mvmbm6tgunu.fsf@suse.de>
 <20181113105717.GA5664@yury-thinkpad>
Message-ID: <20181115005109.73ll47dfwk4uc63r@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 10:57:26AM +0000, Yury Norov wrote:
> On Tue, Nov 13, 2018 at 11:04:53AM +0100, Andreas Schwab wrote:
> > On Jul 24 2018, Yury Norov <ynorov@caviumnetworks.com> wrote:
> > 
> > > This is the update of the series based on 4.17 kernel
> > > https://github.com/norov/linux/tree/ilp32-4.17
> > 
> > Do you aleady have an update for 4.19?
> 
> I've started this work.
> 
> Comparing to 4.17, there are major changes in syscall handling -
> such routines are rewritten in C, and in signals. At now, basic tests
> work, but signal delivering causes illegal instruction abort.

If it helps, I have a 4.18 branch here:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=staging/ilp32-4.18

Hopefully the changes between 4.18 and 4.19 are smaller than .17->.18.

-- 
Catalin
