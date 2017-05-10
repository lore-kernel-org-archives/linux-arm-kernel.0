From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 10 May 2017 00:35:50 -0700
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <CAK8P3a1N6kVEBtSrA+A2QccT0t8P5nHJfui_dYxWd9Tz2Qb63w@mail.gmail.com>
References: <20170428153213.137279-1-thgarnie@google.com>
 <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
 <20170508073352.caqe3fqf7nuxypgi@gmail.com>
 <20170508124621.GA20705@kroah.com>
 <20170509064522.anusoikaalvlux3w@gmail.com>
 <20170509085659.GA32555@infradead.org>
 <CALCETrUh8NO2scaqEM48K70Fo2+V3=Cpyk4JurCDiCYp4nm_+g@mail.gmail.com>
 <20170509130250.GA11381@infradead.org>
 <20170509160322.GA15902@infradead.org>
 <CAK8P3a1N6kVEBtSrA+A2QccT0t8P5nHJfui_dYxWd9Tz2Qb63w@mail.gmail.com>
Message-ID: <20170510073550.GB19359@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 10, 2017 at 09:28:48AM +0200, Arnd Bergmann wrote:
> My older time64_t syscall series has the side-effect of doing something
> like this to the time-related compat handlers in kernel/compat.c. If nobody
> else has started looking at removing set_fs from those, I can extract
> the relevant parts from my series.

That would be great.
