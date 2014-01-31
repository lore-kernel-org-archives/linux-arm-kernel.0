From: Mohit.KUMAR@st.com (Mohit KUMAR DCG)
Date: Fri, 31 Jan 2014 16:50:07 +0800
Subject: [PATCH V3 3/8] SPEAr13xx: defconfig: Update
In-Reply-To: <201401301402.01842.arnd@arndb.de>
References: <cover.1391077731.git.mohit.kumar@st.com>
 <77553346b18c3978b12329161a85dba7d50242ca.1391077731.git.mohit.kumar@st.com>
 <201401301402.01842.arnd@arndb.de>
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189FCF3F0BB@EAPEX1MAIL1.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Thursday, January 30, 2014 6:32 PM
> To: Mohit KUMAR DCG
> Cc: Pratyush ANAND; spear-devel; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V3 3/8] SPEAr13xx: defconfig: Update
> 
> On Thursday 30 January 2014, Mohit Kumar wrote:
> > Enable EABI, OEABI, VFP and NFS configs in default configuration file
> > for SPEAr13xx.
> 
> Are you sure about OABI_COMPAT? That seems unusual.

- yes, this option is not required
> 
> Also, please add all the options you need to multi_v7_defconfig and ensure
> that this configuration works with your hardware as well.

- OK, will do this and test with SPEAr1310.

Thanks
Mohit
