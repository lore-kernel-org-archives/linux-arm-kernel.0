From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Fri, 12 May 2017 09:16:58 +0100
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <20170512081126.GA7188@infradead.org>
References: <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
 <20170508073352.caqe3fqf7nuxypgi@gmail.com>
 <20170508124621.GA20705@kroah.com>
 <20170509064522.anusoikaalvlux3w@gmail.com>
 <20170509085659.GA32555@infradead.org>
 <CALCETrUh8NO2scaqEM48K70Fo2+V3=Cpyk4JurCDiCYp4nm_+g@mail.gmail.com>
 <20170512070012.7dysuhbkcas7ibaj@gmail.com>
 <20170512071549.GP390@ZenIV.linux.org.uk>
 <CAK8P3a2ynRObJLn2Hh2r9_2k5+O08jErPC_UnnDmemd1jXsnkw@mail.gmail.com>
 <20170512081126.GA7188@infradead.org>
Message-ID: <20170512081658.GR390@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 01:11:26AM -0700, Christoph Hellwig wrote:

> But it won't help against exploits modifying addr_limit manually.

Or the ones setting current->cred to that of init.  Your point being?
