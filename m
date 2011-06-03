From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 3 Jun 2011 13:22:18 +0400
Subject: clps711x/ceiva support
In-Reply-To: <20110603053445.GA11543@doriath.ww600.siemens.net>
References: <20110603053445.GA11543@doriath.ww600.siemens.net>
Message-ID: <BANLkTik9xPaM7gqdsfKTxSB29kXpXuZoxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/3/11, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
> Hello,
>
> While doing mtd cleanup, I've stumbled upon clps711x/ceiva platform.
> It's a Ceiva/Polaroid PhotoMax Digital Picture Frame. Support for it was
> commited before 2.6.12-rc2, current git contains no functional changes
> since it's start. Driver containing MTD support for that board was
> broken for some time already.
>
> Artem Bityutskiy asked me to ask on ARM tree if this board is alive or
> not. Are there any objections to drop that board file?

BTW: is the whole clps771x arch used/cared about, or it's just stuck
w/o maintainership and usage?

-- 
With best wishes
Dmitry
