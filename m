From: dianders@chromium.org (Doug Anderson)
Date: Fri, 6 Jun 2014 16:19:59 -0700
Subject: [PATCH v3] clk: exynos5420: Remove aclk66_peric from the clock
 tree description
In-Reply-To: <20140606223123.10062.29366@quantum>
References: <1401467562-5585-1-git-send-email-dianders@chromium.org>
 <1402000514-30752-1-git-send-email-dianders@chromium.org>
 <20140606000324.10062.10257@quantum>
 <CAD=FV=UQhBh68Bgv=kfUROCOxg1dS1OnZ1ir+wouewKoDFE_1g@mail.gmail.com>
 <20140606223123.10062.29366@quantum>
Message-ID: <CAD=FV=Wug+3yanjUJ6OffHggJnKEcWcAKKovtEbswoFDmhevmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

On Fri, Jun 6, 2014 at 3:31 PM, Mike Turquette <mturquette@linaro.org> wrote:
> Anyways, getting back on point, Tomasz was right about the whole clk_get
> thing. So I'm happy to take either V1 or V3 of your patch. I will be
> submitting a second PR for 3.16 next week and it will include whichever
> version you and Tomasz agree is best.

I like V3 slightly better and it has Tomasz's Ack.  Unless he emails
and suggests that he really V1 better then I'd say go with V3.  If we
go back to V1 we'll need to add the "return 0", which I'm happy to do.

Thanks!

-Doug
