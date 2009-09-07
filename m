From: jsgood.yang@samsung.com (Jinsung Yang)
Date: Mon, 07 Sep 2009 19:10:29 +0900
Subject: [PATCH 08/12] [ARM][S3C6410] Add platform device support for
	keypad driver
In-Reply-To: <9c9fda240909061705iae69c65v392af035b29b6549@mail.gmail.com>
References: <00a801ca2e2d$00429510$00c7bf30$%yang@samsung.com>
	<9c9fda240909061705iae69c65v392af035b29b6549@mail.gmail.com>
Message-ID: <002301ca2fa3$6d900450$48b00cf0$%yang@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

> Where's the copyright? Don't forget to add copyright

Sorry, I'll add it.
> > +void __init s3c_keypad_set_platdata(struct s3c_platform_keypad *pd)
> > +{
> > +       struct s3c_platform_keypad *npd;
> > +
> > +       if (!pd)
> > +               pd = &default_keypad_data;
> 
> If you want to set the default it. just assign it at platform_device
> directly. No need to check pd at here.
> 
Ok, got it. I will modify with following your comments.

Best Regards
--
Jinsung, Yang <jsgood.yang@samsung.com>
AP Development Team
System LSI, Semiconductor Business
SAMSUNG Electronics Co., LTD
