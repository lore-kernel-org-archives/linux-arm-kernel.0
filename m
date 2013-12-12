From: Mohit.KUMAR@st.com (Mohit KUMAR DCG)
Date: Thu, 12 Dec 2013 12:55:00 +0800
Subject: [PATCH 06/12] pcie: designware: Move register definition to the
 header file
In-Reply-To: <001001cef6c3$2c5a3cd0$850eb670$%han@samsung.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <CAD6G_RTrETj9p+YNPjRMEFsO7Ggf3LfnuaPOSwO2brUcusNUJw@mail.gmail.com>
 <2CC2A0A4A178534D93D5159BF3BCB66189F95F6311@EAPEX1MAIL1.st.com>
 <201312112231.36039.arnd@arndb.de>
 <001001cef6c3$2c5a3cd0$850eb670$%han@samsung.com>
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189F95F6426@EAPEX1MAIL1.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

> -----Original Message-----
> From: Jingoo Han [mailto:jg1.han at samsung.com]
> Sent: Thursday, December 12, 2013 4:19 AM
> To: Mohit KUMAR DCG; 'Arnd Bergmann'
> Cc: linux-arm-kernel at lists.infradead.org; 'Jagan Teki'; linux-
> pci at vger.kernel.org; spear-devel; Pratyush ANAND; 'Jingoo Han'
> Subject: Re: [PATCH 06/12] pcie: designware: Move register definition to the
> header file
> 
> On Thursday, December 12, 2013 6:32 AM, Arnd Bergmann wrote:
> > On Wednesday 11 December 2013, Mohit KUMAR DCG wrote:
> > > >
> > > > Seems like none were using these headers except pcie-designware.c
> > > > - if ie the case better to place it same place as before.
> > >
> > > - We have include these and used few like '
> > > PCIE_LINK_WIDTH_SPEED_CONTROL '  for SPEAr13xx platform, so move
> these to the separate header  file.
> >
> > I think it's better not to touch any of the registers from a
> > platform-specific driver. Better make a high-level function in the
> > common code that the spear driver can call to change this register.
> 
> I also agree with Arnd's opinion.

- As suggested, I will implement required functions in dw driver and hence no need to move register definitions.

Regards
Mohit 
