From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 13 Nov 2018 10:57:26 +0000
Subject: [PATCH v9 00/24] ILP32 for ARM64
In-Reply-To: <mvmbm6tgunu.fsf@suse.de>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180724173957.GA22106@yury-thinkpad> <mvmbm6tgunu.fsf@suse.de>
Message-ID: <20181113105717.GA5664@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 11:04:53AM +0100, Andreas Schwab wrote:
> External Email
> 
> On Jul 24 2018, Yury Norov <ynorov@caviumnetworks.com> wrote:
> 
> > This is the update of the series based on 4.17 kernel
> > https://github.com/norov/linux/tree/ilp32-4.17
> 
> Do you aleady have an update for 4.19?

I've started this work.

Comparing to 4.17, there are major changes in syscall handling -
such routines are rewritten in C, and in signals. At now, basic tests
work, but signal delivering causes illegal instruction abort.

If you interested in work-in-progress, it's here:
https://github.com/norov/linux/tree/ilp32-4.19.1

I hope finish the rebase till the end of November. If you need it
earlier, please let me know.

Yury
