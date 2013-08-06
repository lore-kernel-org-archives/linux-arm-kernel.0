From: olof@lixom.net (Olof Johansson)
Date: Tue, 6 Aug 2013 10:25:39 -0700
Subject: [PATCH 0/3] ARM: vexpress: TC2 MCPM/SPC cleanups
In-Reply-To: <1375808629.12043.95.camel@hornet>
References: <1375675793-16492-1-git-send-email-olof@lixom.net>
 <20130805094709.GA29090@e102568-lin.cambridge.arm.com>
 <1375805993.12043.80.camel@hornet>
 <CAOesGMiTr1bTE_A=DGrgMQQd3sN9+E6HbahSHKJpOSfouLqHnQ@mail.gmail.com>
 <1375808629.12043.95.camel@hornet>
Message-ID: <CAOesGMhQJ65B1FT15Wivm3=n_TvvTDgisq+6MjXHWF6OfQGuTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 6, 2013 at 10:03 AM, Pawel Moll <pawel.moll@arm.com> wrote:

> I dare to disagree. And the reason is simple - arch/arm64. It's vexpress
> as well, and we'll be in the same position.

Actually, no -- PSCI will be mandatory there so there will be no need
to have these kernel components.


-Olof
