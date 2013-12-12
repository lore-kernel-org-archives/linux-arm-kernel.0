From: Mohit.KUMAR@st.com (Mohit KUMAR DCG)
Date: Thu, 12 Dec 2013 12:47:23 +0800
Subject: [PATCH 10/12] SPEAr13xx: defconfig: Update
In-Reply-To: <52A842A7.1030605@st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <3bc935718da3e0118c57ebee80c1363aac4a48a5.1386752447.git.mohit.kumar@st.com>
 <52A842A7.1030605@st.com>
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189F95F641D@EAPEX1MAIL1.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rajeev,

> -----Original Message-----
> From: Rajeev KUMAR
> Sent: Wednesday, December 11, 2013 4:17 PM
> To: Mohit KUMAR DCG
> Cc: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> Pratyush ANAND; Viresh Kumar; spear-devel
> Subject: Re: [PATCH 10/12] SPEAr13xx: defconfig: Update
> 
> On 12/11/2013 3:08 PM, Mohit KUMAR wrote:
> > Enable EABI, OEABI, VFP and NFS configs in default configuration file
> > for SPEAr13xx.
> >
> > Enable PCIe support for SPEAr13xx.

[...]
> >   CONFIG_JFFS2_FS=y
> > +CONFIG_NFS_FS=y
> > +CONFIG_ROOT_NFS=y
> 
> Its better to enable CONFIG_FUSE_FS also in case you want to work with
> fully functional NFS in userspace.

- OK, will enable this option.

Thanks
Mohit
