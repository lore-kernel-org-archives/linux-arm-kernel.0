From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 17 Apr 2016 00:02:54 +0900
Subject: [Question] refcount of DT node
In-Reply-To: <20160414183855.GU19428@n2100.arm.linux.org.uk>
References: <CAK7LNATFUW2KXUpFas6C_SJ0C7Qb1DWU0njLg-FCYciK2U6Oag@mail.gmail.com>
 <20160414084849.GT19428@n2100.arm.linux.org.uk>
 <20160414095957.GB10273@leverpostej>
 <20160414183855.GU19428@n2100.arm.linux.org.uk>
Message-ID: <CAK7LNAQiw4VT5Cs1KzXg_K6r8QjiPd8o9xo_oaix0DOXYosK=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi experts.


2016-04-15 3:38 GMT+09:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:

>
> Their stance is not something I agree with - if we have something,
> it should be correct, even if it's not what we would ultimately
> desire, _or_ it should be removed.  This half-way house that we
> have today is total madness to me.

I agree with Russell here.

I am comfortable to do my best in the given API at this point
(and also happy to adjust my drivers when a new API is supported in the future).

So, the answers from DT people are really helpful for me to write correct code.

Thank you everyone!



-- 
Best Regards
Masahiro Yamada
