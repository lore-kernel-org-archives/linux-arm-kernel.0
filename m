From: eballetbo@gmail.com (=?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?=)
Date: Mon, 16 May 2011 09:17:53 +0200
Subject: [RESEND PATCH 2/4] omap: igep0020: minor refactoring
In-Reply-To: <201105152228.00408.arnd@arndb.de>
References: <cover.1305235542.git.mike@compulab.co.il>
	<201105132044.39163.arnd@arndb.de>
	<20110515185043.GA24785@gentoodev.compulab.local>
	<201105152228.00408.arnd@arndb.de>
Message-ID: <BANLkTi=PGq4qp8pZorR1UUp0NdEL1WkfJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/15 Arnd Bergmann <arnd@arndb.de>:
> On Sunday 15 May 2011, mike at compulab.co.il wrote:
>> We can keep all the data structures that differ between IGEP2 and IGEP3.
>> However, this significantly reduces the benifit of the series.
>> There's already code in the IGEP2 that differentiates between HW
>> revisions, so anyway the board support will require some work for
>> devicetree transition. Eventually, when devicetree will be usable on
>> OMAPs, most of the code currently found in arch/arm/mach-omap2/board*
>> will require some work and I hardly believe that the transition can be
>> automated...
>
> True. Let's just use the version you posted then.
>
> ? ? ? ?Arnd
>

Acked-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
