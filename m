From: dianders@chromium.org (Doug Anderson)
Date: Mon, 3 Jun 2013 17:07:26 -0700
Subject: [PATCH V4 2/4] clk: samsung: register audio subsystem clocks
 using common clock framework
In-Reply-To: <CAL1qeaEkomoDQPyGqqLL-WzoLS=nND-eXeRAGD2HpoV6WW3yRQ@mail.gmail.com>
References: <1370236744-16802-1-git-send-email-padma.v@samsung.com>
 <1370236744-16802-3-git-send-email-padma.v@samsung.com>
 <CAD=FV=XOfi=BsaF+-96SqKwyiwP9h0h3MCJxJ+qWNKaGoP=CcA@mail.gmail.com>
 <CAL1qeaEkomoDQPyGqqLL-WzoLS=nND-eXeRAGD2HpoV6WW3yRQ@mail.gmail.com>
Message-ID: <CAD=FV=Wu6u=gvh5Anut8MtC+Bb43EG7hxRN=vs-ML35P1qTJYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Mon, Jun 3, 2013 at 4:46 PM, Andrew Bresticker <abrestic@chromium.org> wrote:
>> I think this is supposed to be "xxti" which might or might not be
>> "fin_pll".  In the exynos4 code these are two different clocks that
>> are chosen by OM[0].  I'd bet that 99% of the time they are the same,
>> but it seems better to use "xxti".
>
> OM[0] also appears to mux the input here between "xxti" and "xusbxti"
> as well.  So this should probably remain "fin_pll".

Thanks!  ...so I'm OK with this landing "as-is" or a re-spin with nits
fixed, since all of the rest of my comments were just nits...
