From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 17 Jul 2018 05:58:55 -0700
Subject: [PATCH] [RFC] y2038: globally rename compat_time to old_time32
In-Reply-To: <CAK8P3a2xu4KGVM1BvTjtXKHfXpBQ2PMynAPybW4cRt7FB8ktwg@mail.gmail.com>
References: <20180713133204.3123939-1-arnd@arndb.de>
 <CABeXuvphoYM+KOGPgtsuxzS1_XDSOO0Ta5hr3sA7gYtt-78wtQ@mail.gmail.com>
 <CAK8P3a2xu4KGVM1BvTjtXKHfXpBQ2PMynAPybW4cRt7FB8ktwg@mail.gmail.com>
Message-ID: <20180717125855.GA3681@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 12:11:53PM +0200, Arnd Bergmann wrote:
> I don't think it makes a big difference whether we change it now or later,
> but if Christoph feels that it addresses his concern about the compat_
> namespace being reused during the transition, doing it earlier would
> enable us to finish the remaining syscalls.

Yes, I've been looking at your new series and the reuse of compat_*
is really confusing
