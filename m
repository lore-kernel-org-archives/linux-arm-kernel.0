From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Nov 2012 09:08:40 +0000
Subject: [GIT PULL] ASoC: Samsung: Updates for v3.8
In-Reply-To: <CAAgF-Bfv46Xt0hFdPmviCdZbpje1M4MBnmCsHGgdOjcq4SnuJw@mail.gmail.com>
References: <001601cdcd28$ce5204c0$6af60e40$@com>
 <CAAgF-Bfv46Xt0hFdPmviCdZbpje1M4MBnmCsHGgdOjcq4SnuJw@mail.gmail.com>
Message-ID: <20121128090840.GH32691@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 11:21:31AM +0530, Padma Venkat wrote:
> On Wed, Nov 28, 2012 at 10:55 AM, Sangbeom Kim <sbkim73@samsung.com> wrote:

> >> > The requirement for an alias is also very odd, where does that come from?

> >> I don't know that Which one is odd. Please let me know.

> > Having them at all is odd - it's not something other DT bindings have needed and there was nothing
> > saying what it was for.

> What is the exact requirement here? Should I remove the alias ids or
> I2S1 and I2S2 nodes as they are in disabled state? This is done same
> way as SPI and I2C. Please explain me.

If you need those aliases you need to explain why.  They're listed as
mandatory so presumably they must be needed for something?  It might be
that this is a good idea we didn't think of before so the answer is just
to document that rather than remove them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121128/ee60652f/attachment-0001.sig>
