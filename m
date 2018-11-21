From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Wed, 21 Nov 2018 17:21:04 +0800
Subject: [PATCH v1 04/11] soc: mediatek: add new flow for mtcmos power.
In-Reply-To: <154278766192.88331.16232130563413450456@swboyd.mtv.corp.google.com>
References: <20181106064206.17535-1-weiyi.lu@mediatek.com>
 <20181106064206.17535-6-weiyi.lu@mediatek.com>
 <CANMq1KDbauouMDvsZS3KsNJrNs1gGg7mDjsKRw=zTcuQXSTa0Q@mail.gmail.com>
 <1542681454.5132.9.camel@mtksdaap41>
 <154278766192.88331.16232130563413450456@swboyd.mtv.corp.google.com>
Message-ID: <1542792064.20593.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-11-21 at 00:07 -0800, Stephen Boyd wrote:
> Quoting Weiyi Lu (2018-11-19 18:37:34)
> > On Tue, 2018-11-13 at 11:31 -0800, Nicolas Boichat wrote:
> > > On Mon, Nov 5, 2018 at 10:42 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> 
> > > > @@ -226,6 +397,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
> > > >         if (ret < 0)
> > > >                 goto err_pwr_ack;
> > > >
> > > > +
> > > 
> > > Drop this.
> > Why do we try to drop this? Once the power-on step fail, the following
> > steps should not be permitted.
> 
> I just see a whitespace addition that doesn't do anything. I suspect
> it's a style nitpick and common practice to not include spurious diffs
> in the patch. So remove this hunk?
> 
Oops! I missed the extra whitespace. I will remove it. Many thanks.
