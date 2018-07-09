From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 09 Jul 2018 12:06:57 +0200
Subject: [PATCH 0/3] PM / Domains: Enable name based lookup at attach
In-Reply-To: <20180702070806.tuzzh6mu65lrq4xq@vireshk-i7>
References: <20180629110432.5179-1-ulf.hansson@linaro.org>
 <20180702070806.tuzzh6mu65lrq4xq@vireshk-i7>
Message-ID: <12075152.c01WRJ509Y@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 2, 2018 9:08:06 AM CEST Viresh Kumar wrote:
> On 29-06-18, 13:04, Ulf Hansson wrote:
> > Recently we added support to manage multiple PM domains per device. Consumer
> > drivers were provided an API, dev_pm_domain_attach_by_id() to associate its
> > device with one of its PM domain, by using an index.
> > 
> > Let's extend this to allow the association to be done using a name based
> > lookup, which follows the similar concept as for other resource types, such as
> > clocks for example.
> > 
> > Ulf Hansson (3):
> >   PM / Domains: dt: Add a power-domain-names property
> >   PM / Domains: Introduce option to attach a device by name to genpd
> >   PM / Domains: Introduce dev_pm_domain_attach_by_name()
> 
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

Do we need Rob to ACK the binding change?
