From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Mar 2013 13:32:16 +0000
Subject: [PATCH v4 5/5] ARM: config: append arch hi3xxx into multi
 defconfig
In-Reply-To: <CAD6h2NSk_q6ru3AOtG-ZNDXkvFCggNkDGWJQy3LMRubZ8ZGHQw@mail.gmail.com>
References: <1363245584-24488-1-git-send-email-haojian.zhuang@linaro.org>
 <201303140910.36483.arnd@arndb.de>
 <CAD6h2NSk_q6ru3AOtG-ZNDXkvFCggNkDGWJQy3LMRubZ8ZGHQw@mail.gmail.com>
Message-ID: <201303141332.17124.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 March 2013, Haojian Zhuang wrote:
> On 14 March 2013 17:10, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Are you sure this is enough? Normally we also have to enable
> > some device drivers to get a bootable system.
> >
> Yes, it could boot.  Those components are already enabled in multi_v7_defconfig.
> Since hi3xxx used a lot of AMBA IPs.

Ok, very good then.

	Arnd
