From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 20 Oct 2016 12:36:19 +0200
Subject: [PATCH 15/19] reset: sti: Remove STiH415/6 reset support
In-Reply-To: <b9a50ba1-9932-0d71-6b61-efccee587d74@st.com>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-16-git-send-email-peter.griffin@linaro.org>
 <1474963347.2494.8.camel@pengutronix.de>
 <b9a50ba1-9932-0d71-6b61-efccee587d74@st.com>
Message-ID: <1476959779.2709.39.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 11.10.2016, 09:05 +0200 schrieb Patrice Chotard:
> Hi Philipp
> 
> On 09/27/2016 10:02 AM, Philipp Zabel wrote:
> > Hi Peter,
> > 
> > Am Mittwoch, den 14.09.2016, 14:27 +0100 schrieb Peter Griffin:
> >> Support for STiH415/6 SoCs is being removed from the
> >> kernel because the platforms are obsolete. This patch removes
> >> the reset drivers for these SoC's.
> >>
> >> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> >> Cc: <p.zabel@pengutronix.de>
> >> ---
> 
> [...]
> 
> >> -	.driver = {
> >> -		.name = "reset-stih416",
> >> -		.of_match_table = stih416_reset_match,
> >> -	},
> >> -};
> >> -
> >> -static int __init stih416_reset_init(void)
> >> -{
> >> -	return platform_driver_register(&stih416_reset_driver);
> >> -}
> >> -arch_initcall(stih416_reset_init);
> > 
> > Can I pick up patches 15 and 19, or are there dependencies in the
> > series?
> 
> Yes, you can pick up patches 15 and 19

Done.

regards
Philipp
