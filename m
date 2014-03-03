From: Mohit.KUMAR@st.com (Mohit KUMAR DCG)
Date: Mon, 3 Mar 2014 12:45:21 +0800
Subject: [PATCH V7 07/10] SPEAr13XX: dts: Add PCIe node information
In-Reply-To: <7430033.eK9aHCDe8b@wuerfel>
References: <cover.1393568715.git.mohit.kumar@st.com>
 <b02c2cf599817a852e0cdb2e24e76e74da02637d.1393568715.git.mohit.kumar@st.com>
 <7430033.eK9aHCDe8b@wuerfel>
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189FD519B2E@EAPEX1MAIL1.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Friday, February 28, 2014 5:28 PM
> To: Mohit KUMAR DCG
> Cc: Pratyush ANAND; Viresh Kumar; spear-devel; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH V7 07/10] SPEAr13XX: dts: Add PCIe node information
> 
> On Friday 28 February 2014 17:25:00 Mohit Kumar wrote:
> > +                       interrupts = <0 68 0x4>;
> > +                       interrupt-map-mask = <0 0 0 0>;
> > +                       interrupt-map = <0x0 0 &gic 68>;
> >
> 
> From the discussion we just had on the imx version of this driver, I suspect
> what you want instead is to drop the interrupts property and fix the interrupt
> map to be
> 
> interrupt-map = <0x0 0 &gic 0 68 0x4>;
> 

- yes, I should have fix interrupt map. Pls let us know if any other point needs to be
Incorporated in this series.

Regards
Mohit
