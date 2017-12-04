From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Mon, 4 Dec 2017 12:31:20 +0100
Subject: [PATCH 11/12] ARM: dts: imx6qdl-nitrogen6_max: Remove unneeded
 unit address
In-Reply-To: <CAOMZO5C77f9mQQWJ5GJH3J+cj4Fxu3H-3yQYeFNDxm3xfpe8Gw@mail.gmail.com>
References: <1512156285-18451-1-git-send-email-festevam@gmail.com>
 <1512156285-18451-11-git-send-email-festevam@gmail.com>
 <20171204111954.v7jexbtkjyaa6mhe@t450s.lan>
 <CAOMZO5C77f9mQQWJ5GJH3J+cj4Fxu3H-3yQYeFNDxm3xfpe8Gw@mail.gmail.com>
Message-ID: <20171204113120.wbofrsoxl2ekd3ch@t450s.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Mon, Dec 04, 2017 at 09:28:08AM -0200, Fabio Estevam wrote:
> Hi Gary,
> 
> On Mon, Dec 4, 2017 at 9:19 AM, Gary Bisson
> <gary.bisson@boundarydevices.com> wrote:
> 
> > What about naming it i2c2mux and i2c3mux so it is clearer those mux
> > happen respectively for i2c2 and i2c3?
> >
> > Then I'd rename the sub-nodes i2cXmux at Y instead of i2cX at Y currently.
> >
> > Let me know your thoughts.
> 
> Is this what you suggest?

Yes exactly, I find it clearer, what do you think?

Regards,
Gary
