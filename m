From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 24 Jul 2012 17:06:23 +0100
Subject: PL192 VIC Support
In-Reply-To: <20120724160221.GJ16435@mudshark.cambridge.arm.com>
References: <20120724160221.GJ16435@mudshark.cambridge.arm.com>
Message-ID: <CACb=_tSsc0ycTmR-60PyrGJeX7otYTZ4XOvmy1PEJQ2a8Ri-RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 24 July 2012 17:02, Will Deacon <will.deacon@arm.com> wrote:
> I notice that in a number of the picoxcell-pc*.dtsi files there is mention
> of a PL192 VIC (the "arm,pl192-vic" binding).
>
> Does the picoxcell platform actually have a PL192, or is it a PL190? I ask
> because it doesn't look like the VIC driver in mainline supports the PL192
> and I wondered if you had any patches.

Yes, picoxcell has 2 PL192's, but in the way that their used for that
platform it's compatible with PL190 (at least enough to run Linux
anyway).  That was always sufficient for what we needed so I never
attempted to add anything else to that driver.

Jamie
