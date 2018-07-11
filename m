From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 11 Jul 2018 11:43:52 +0200
Subject: [PATCH 0/3] PM / Domains: Enable name based lookup at attach
In-Reply-To: <CAPDyKFq=EPkvu0MjOtkjCNzrgZj0kaJTxXDt21=YR==T+H8ePQ@mail.gmail.com>
References: <20180629110432.5179-1-ulf.hansson@linaro.org>
 <12075152.c01WRJ509Y@aspire.rjw.lan>
 <CAPDyKFq=EPkvu0MjOtkjCNzrgZj0kaJTxXDt21=YR==T+H8ePQ@mail.gmail.com>
Message-ID: <34035286.gLvmaz061p@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 9, 2018 1:38:38 PM CEST Ulf Hansson wrote:
> On 9 July 2018 at 12:06, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Monday, July 2, 2018 9:08:06 AM CEST Viresh Kumar wrote:
> >> On 29-06-18, 13:04, Ulf Hansson wrote:
> >> > Recently we added support to manage multiple PM domains per device. Consumer
> >> > drivers were provided an API, dev_pm_domain_attach_by_id() to associate its
> >> > device with one of its PM domain, by using an index.
> >> >
> >> > Let's extend this to allow the association to be done using a name based
> >> > lookup, which follows the similar concept as for other resource types, such as
> >> > clocks for example.
> >> >
> >> > Ulf Hansson (3):
> >> >   PM / Domains: dt: Add a power-domain-names property
> >> >   PM / Domains: Introduce option to attach a device by name to genpd
> >> >   PM / Domains: Introduce dev_pm_domain_attach_by_name()
> >>
> >> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> >>
> >>
> >
> > Do we need Rob to ACK the binding change?
> >
> 
> Normally, yes, however, the change to binding is trivial and the
> concept of using a names property isn't something new. I would be
> highly surprised if he would object.
> 
> I say apply it.

OK, applied along with the other two.

Thanks!
