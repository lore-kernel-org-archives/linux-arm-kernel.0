From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 27 Sep 2011 20:18:27 +0530
Subject: [PATCH 4/9] regulator: twl: Make twl-regulator driver extract
	data from DT
In-Reply-To: <20110927121415.GC4289@opensource.wolfsonmicro.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-5-git-send-email-rnayak@ti.com>
	<20110927121415.GC4289@opensource.wolfsonmicro.com>
Message-ID: <4E81E23B.8040706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 September 2011 05:44 PM, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 03:42:47PM +0530, Rajendra Nayak wrote:
>
>> +#ifdef CONFIG_OF
>> +	char			compatible[128];
>> +#endif
>
> Might it not be better to just make this a pointer to const char?

Yes, my bad.
