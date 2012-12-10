From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Dec 2012 19:16:11 +0000
Subject: [PATCH] ARM: head: Remove boot-time HYP mode check for v5 and
 below
In-Reply-To: <50C62510.7050204@arm.com>
References: <1354887959-14863-1-git-send-email-dave.martin@linaro.org>
 <20121210105743.GA1953@linaro.org>
 <CAHod+GdDN-hMKreQNXfGpe9vDLV8+a55JFM2R4wW_r5kyFaYww@mail.gmail.com>
 <20121210180235.GC1953@linaro.org> <50C62510.7050204@arm.com>
Message-ID: <20121210191611.GJ12030@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 06:08:16PM +0000, Marc Zyngier wrote:
> On 10/12/12 18:02, Dave Martin wrote:
> > This typo is in the existing code, not part of the fix.
> > I'll try to tidy this up if I touch this code again.
> 
> I think Will already carries a patch authored by RMK, getting rid of the
> use of LR and of my spelling mistake.

Yup, I was planning to post a patch series after the merge window which
removed the CONFIG_ARM_VIRT_EXT option entirely. However, given the Zaurus
breakage I'll rework that series to default the option to y and hide it from
the user, so this patch will ultimately disappear (but is a good short-term
fix).

Will
