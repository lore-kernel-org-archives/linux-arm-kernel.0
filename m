From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 18 Apr 2017 10:45:26 +0530
Subject: [PATCH V2] PM / OPP: Use - instead of @ for DT entries
In-Reply-To: <6048149.VQXQ7HobDf@aspire.rjw.lan>
References: <70e7c7ee13722ab9c73cb073f88502eaf1ada5f5.1491816050.git.viresh.kumar@linaro.org>
 <CAK7LNAQ7Uf1Jkj64-Ykdk5TSeWvkq7=BaqUMJo6KqrN7BhYvsQ@mail.gmail.com>
 <22966574.2zMrIUgKz4@aspire.rjw.lan>
 <6048149.VQXQ7HobDf@aspire.rjw.lan>
Message-ID: <20170418051526.GN28191@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17-04-17, 18:40, Rafael J. Wysocki wrote:
> On Monday, April 17, 2017 06:35:25 PM Rafael J. Wysocki wrote:
> > On Monday, April 17, 2017 11:07:51 AM Masahiro Yamada wrote:
> > > 2017-04-15 7:47 GMT+09:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> > > > On Monday, April 10, 2017 02:51:35 PM Viresh Kumar wrote:
> > > >> Compiling the DT file with W=1, DTC warns like follows:
> > > >>
> > > >> Warning (unit_address_vs_reg): Node /opp_table0/opp at 1000000000 has a
> > > >> unit name, but no reg property
> > > >>
> > > >> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> > > >> "reg" property.
> > > >>
> > > >> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > >> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > >> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > > >> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > >> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com> (sunxi)
> > > >> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> > > >> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > >
> > > > OK, so any ACKs from the DT side?  Rob?
> > > >
> > > > Thanks,
> > > > Rafael
> > > 
> > > 
> > > 
> > > I see Rob's Acked-by.
> > > 
> > > https://lkml.org/lkml/2017/4/13/648
> > 
> > Indeed.  Thanks!
> 
> But it doesn't apply on top of -rc7 for me, so I guess there is new 4.12-candidate
> material in the DTS tree that conflicts with this, in which case it is better to route
> it through the DTS tree IMO.

Yes a minor conflict. I have sent the rebased version now, see if you
want to apply it directly or want arm-soc guys to do it.

-- 
viresh
