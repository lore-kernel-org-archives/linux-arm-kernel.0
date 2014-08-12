From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 Aug 2014 11:28:07 +0100
Subject: [PATCH 2/2] asm-generic: add memfd_create system call to unistd.h
In-Reply-To: <201408112057.01177.arnd@arndb.de>
References: <1407764228-7904-1-git-send-email-will.deacon@arm.com>
 <CANq1E4Q0gDaJ5XGnkoCQsG8xLh1Q-EBErtEVPpeeZgGj+Nr8dQ@mail.gmail.com>
 <20140811171511.GF8828@arm.com> <201408112057.01177.arnd@arndb.de>
Message-ID: <20140812102807.GH29013@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 07:57:00PM +0100, Arnd Bergmann wrote:
> On Monday 11 August 2014, Will Deacon wrote:
> > On Mon, Aug 11, 2014 at 05:54:08PM +0100, David Herrmann wrote:
> > > On Mon, Aug 11, 2014 at 3:37 PM, Will Deacon <will.deacon@arm.com> wrote:
> > > > Commit 9183df25fe7b ("shm: add memfd_create() syscall") added a new
> > > > system call (memfd_create) but didn't update the asm-generic unistd
> > > > header.
> > > >
> > > > This patch adds the new system call to the asm-generic version of
> > > > unistd.h so that it can be used by architectures such as arm64.
> > > >
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Cc: David Herrmann <dh.herrmann@gmail.com>
> > > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > 
> > > Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
> > 
> > Thanks, David.
> > 
> > Arnd: shall I take this via the arm64 tree, or do you already have some
> > asm-generic patches queued?
> 
> Please take it for arm64, I don't have any other patches queued at the moment
> and am currently on vacation.

Thanks, Arnd. I'll include it with the arm64 pull req at -rc1.

Have a good holiday,

Will
