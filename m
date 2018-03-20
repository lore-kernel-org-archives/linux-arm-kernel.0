From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 20 Mar 2018 09:22:12 -0700
Subject: [PATCH v6 16/20] clk: add support for clocks provided by SCMI
In-Reply-To: <6b5a56f7-ff0d-dde2-097b-bf245971e8a6@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
 <1519403030-21189-17-git-send-email-sudeep.holla@arm.com>
 <152124137391.242365.17144416413429914606@swboyd.mtv.corp.google.com>
 <6b5a56f7-ff0d-dde2-097b-bf245971e8a6@arm.com>
Message-ID: <152156293212.254778.7714453841547508122@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sudeep Holla (2018-03-20 05:08:51)
> 
> >> +}
> >> +
> >> +static void scmi_clocks_remove(struct scmi_device *sdev)
> >> +{
> >> +       struct device *dev = &sdev->dev;
> >> +       struct device_node *np = dev->of_node;
> >> +
> >> +       of_clk_del_provider(np);
> >> +}
> >> +
> > 
> > Drop?
> > 
> 
> Sure, I will have to do these changes as add-on patch as this original
> patch is already queued in ARM SoC tree for v4.17
> 

Ok!
