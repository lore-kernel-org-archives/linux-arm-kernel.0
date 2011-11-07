From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 07 Nov 2011 11:57:15 +0530
Subject: [PATCH v4 1/4] regulator: helper routine to extract
 regulator_init_data
In-Reply-To: <20111104212216.GA5756@quad.lixom.net>
References: <1319721864-30067-1-git-send-email-rnayak@ti.com>
 <20111104202905.GA3918@quad.lixom.net>
 <20111104211447.GC2541@opensource.wolfsonmicro.com>
 <20111104212216.GA5756@quad.lixom.net>
Message-ID: <4EB77A43.8050206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 05 November 2011 02:52 AM, Olof Johansson wrote:
>>> >  >  Also, lower-caps is common instead of V and A.
>> >
>> >  On the other hand the case is pretty important for SI units
> Yeah, true. The fixed regulators used microvolt instead, which could be a good
> way to do it.
>

Ok, will use microvolt and microamp across all bindings.
