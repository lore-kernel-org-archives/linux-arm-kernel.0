From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 17 Jan 2011 11:43:11 -0800
Subject: [PATCH 27/48] ARM: PL08x: avoid duplicating registers in txd and
	phychan structures
In-Reply-To: <20110117085012.GA17036@n2100.arm.linux.org.uk>
References: <E1PZt3Z-00025W-0c@rmk-PC.arm.linux.org.uk>
	<AANLkTi=GsMaDQDSuR=Z4AT4Vk4GThx6O_0Le=pjsu9gj@mail.gmail.com>
	<20110115092324.GX15996@n2100.arm.linux.org.uk>
	<AANLkTim_1yK_Q7sy4a1iMX2zXG1p3EJ0avGvcYeTP9Us@mail.gmail.com>
	<20110116123615.GC27542@n2100.arm.linux.org.uk>
	<AANLkTi=s-CQVEj4wOZo8cCbzWnj5G0p_COtKoQt7Xzy8@mail.gmail.com>
	<20110116195948.GA4864@n2100.arm.linux.org.uk>
	<4D334F15.3080705@intel.com>
	<20110116201805.GB4864@n2100.arm.linux.org.uk>
	<AANLkTikC7gewBjB_5ebi11J_Brpoc6p=3bWLb=8WdUk_@mail.gmail.com>
	<20110117085012.GA17036@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikn6T-FQbssHY1rQnZBJ8E+CVNHqofEhFM35U_K@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 12:50 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Sigh - but that was the original problem which was complained about -
> llis_va was void pointer not a struct.
>
> So what was the point of asking me for some random patch again?
>
> I'm confused.

Me too... we did a fire drill to make sure the series was applied
correctly and I thought the outcome was that you found one more
straggling patch to include.

In any event I think we are all set now.

--
Dan
