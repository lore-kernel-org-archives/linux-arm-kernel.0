From: nm@ti.com (Nishanth Menon)
Date: Tue, 25 Jun 2013 15:17:55 -0500
Subject: [PATCH] ARM: omap5: build opp4xxx_data.c
In-Reply-To: <51C9F993.6050109@ti.com>
References: <201306212229.54238.arnd@arndb.de> <20130621204250.GA16139@kahuna>
 <alpine.DEB.2.02.1306251918590.14373@utopia.booyaka.com>
 <51C9F595.3060609@ti.com> <20130625195751.GA6529@kahuna>
 <51C9F993.6050109@ti.com>
Message-ID: <CAGo_u6rQG7h2aPSErwKR1H7PYE5QdxXU3Dd5z13-rPkbVtkcUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 3:12 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>
> Well having voltage data in voltage domain was not my decision ;-)
> Instead of creating another set of dummy data, I just used what
> is out there(OMAP4) with clear comment that data needs to be updated.
> I don't see any problem in this considering we have devices booting
> and working nicely for OMAP5
I really wish the OMAP5 devices(the latest ones from Fab) I have would
like to function at OMAP4 configurations! Unfortunately the devices
tend to follow the data manual for OMAP5.
*if* there is no need for it to boot, I suggest removing it.

Regards,
Nishanth Menon
