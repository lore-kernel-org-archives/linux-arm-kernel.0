From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 May 2016 12:23:50 +0100
Subject: [linux-sunxi] [PATCH 1/5] spi: sunxi: fix transfer timeout
In-Reply-To: <CAGRGNgW=UnmwwiREV+nVcws6sk18-4fKz3qf-WKf4LY9-VqBKg@mail.gmail.com>
References: <cover.1464130597.git.hramrach@gmail.com>
 <cb90b922caa6ac07c1425d726ea19709ee5284f4.1464130597.git.hramrach@gmail.com>
 <CAGRGNgWDrVHG26umTSHHAxFC3KXjwmpDejBAfKqvuik0_2-Jcw@mail.gmail.com>
 <CAOMqctS0AD6rHGt3wjxxyidee=_5xqby95t5TGuozAA12DdPjQ@mail.gmail.com>
 <CAGRGNgW=UnmwwiREV+nVcws6sk18-4fKz3qf-WKf4LY9-VqBKg@mail.gmail.com>
Message-ID: <20160530112350.GI29837@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2016 at 03:10:11PM +1000, Julian Calaby wrote:
> On Fri, May 27, 2016 at 3:05 PM, Michal Suchanek <hramrach@gmail.com> wrote:

> >> Also, should the changes for the drivers be in two separate patches also?

> > That's basically the same driver with different constants so I guess not.

> Fair enough, I withdraw my comment then.

If it's the same driver with different constants it should really
actually be the same driver - I did ask this when the drivers were
originally merged...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160530/fafb72c7/attachment.sig>
