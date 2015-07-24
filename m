From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 24 Jul 2015 20:02:33 +0200
Subject: [PATCH 05/10] opp: Add support to parse "operating-points-v2"
 bindings
In-Reply-To: <20150709051845.GM1805@linux>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <2910042.ys2zsBBKt2@amdc1976> <20150709051845.GM1805@linux>
Message-ID: <9723014.v9tt0Yn4CZ@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Thursday, July 09, 2015 10:48:46 AM Viresh Kumar wrote:
> On 08-07-15, 15:41, Bartlomiej Zolnierkiewicz wrote:
> > Isn't using u32 for storing frequency (in Hz) too small by today's
> > standards?
> > 
> > [ Please note that the old v1 binding uses kHz not Hz. ]
> 
> Hmm, probably yes we need it to be u64. Thanks for pointing out.

There is also a minor issue with of_init_opp_table() documentation
(the function can now return -EINVAL in some cases).  Except these
two things the patch looks fine and once it is fixed you can add:

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
