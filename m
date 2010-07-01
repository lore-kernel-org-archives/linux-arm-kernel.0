From: ivo.clarysse@gmail.com (Ivo Clarysse)
Date: Thu, 1 Jul 2010 16:24:39 +0200
Subject: [PATCHv3 4/5] mtd: mxc_nand fixups
In-Reply-To: <80y6e2kv9s.fsf@merkur.tec.linutronix.de>
References: <20100618205401.GA12115@pengutronix.de>
	<80sk4ivkga.fsf@merkur.tec.linutronix.de>
	<AANLkTimA7Rbm_nHpVYpEPqaPCjrOse9s8YyiInWlhfEK@mail.gmail.com>
	<80tyoyhxey.fsf_-_@merkur.tec.linutronix.de>
	<AANLkTikRj_dMkKLyFhW78yld9jIYAIFncfPaPAF8WqUY@mail.gmail.com>
	<80iq5bqd07.fsf_-_@merkur.tec.linutronix.de>
	<AANLkTimJKNEwOoKldq4a4_ufxNY6IY7r6tAfAM055hlW@mail.gmail.com>
	<80vd9ab0d2.fsf@merkur.tec.linutronix.de>
	<AANLkTinVaXjCneg-XpxB7YNlmGOwQFTnm5RUcetPdToI@mail.gmail.com>
	<80lja6awlb.fsf@merkur.tec.linutronix.de>
	<20100624072732.GQ12115@pengutronix.de>
	<807hloag6w.fsf@merkur.tec.linutronix.de>
	<AANLkTilTbvlPxRhioMiKrBUNggcxZeboi1YpB8Y9Bdpm@mail.gmail.com>
	<80y6e2kv9s.fsf@merkur.tec.linutronix.de>
Message-ID: <AANLkTinX8pSaIq__XdjEugMu-1w_ZsHosyZb7OXAi98g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 26, 2010 at 11:17 AM, John Ogness <john.ogness@linutronix.de> wrote:
> On 2010-06-25, Ivo Clarysse <ivo.clarysse@gmail.com> wrote:
>> Tested on an MX21ADS board, and it still works.
>>
>> [...]
>>
>> Naming is not very consistent; I'd suggest nfc_set_interrupt /
>> nfc_clear_interrupt
>
> Actually, the set function is a query, not an action. I've renamed it
> nfc_isset_interrupt() so that it is clearer. I also fixed a typo in one
> of the comments.
>
> This patch is based on linux-next 20100618.
[...]

Verified as working successfully on an MX21ADS board.

Ivo.
