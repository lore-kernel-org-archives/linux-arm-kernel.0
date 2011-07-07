From: heechul@illinois.edu (heechul Yun)
Date: Wed, 6 Jul 2011 19:53:23 -0700
Subject: A few other cache related optimizations for Cortex-A9.
In-Reply-To: <20110706193055.GO8286@n2100.arm.linux.org.uk>
References: <CAN_5kQBszi=hV1RVjyKO6gOhOuymGjsMwLk6ORaWpkaL-4USxA@mail.gmail.com>
	<20110706085656.GA32020@e102109-lin.cambridge.arm.com>
	<20110706193055.GO8286@n2100.arm.linux.org.uk>
Message-ID: <CAN_5kQB_s8aTKrvDc9n2vC4eGUbArUvWD2z-isNHa-SQ2U-pzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> We don't need this flush anymore, so let's simply kill it outright.
>
> Heechul (sorry, is that the correct way of addressing you?) could
> you please submit a patch removing the __cpuc_flush_dcache_area()
> from v6_copy_user_highpage_nonaliasing() entirely please?
>

I sent the patch

Thanks

Heechul
