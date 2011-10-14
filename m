From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 14 Oct 2011 19:05:44 +0200
Subject: [PATCH v3 1/6] iommu/core: split mapping to page sizes as
	supported by the hardware
In-Reply-To: <CAK=Wgbar+z_Nm1cDM4bJgrP5yWbjCsVBW=orfYwsZsT7uET8ng@mail.gmail.com>
References: <20110927131222.GL2138@amd.com>
	<CAK=WgbYG2tpMJ2SikZhm=R9j5kQ6Hm8CGg=q1bko3idzF53Q3Q@mail.gmail.com>
	<20110927181438.GM2138@amd.com>
	<CAK=WgbbNs5fWHDEputZ=jzU5YN0sn0tf6AETkcsoq_Jbvc2XgQ@mail.gmail.com>
	<20111010094738.GW2138@amd.com>
	<CAK=WgbZ7Wyax1yfS1jSXw9OdwMtxxidwLO8PTsNUXX9CWzmVrw@mail.gmail.com>
	<20111010153609.GB2138@amd.com>
	<CAK=WgbbnuO67X46sqS87q2vw2TWq3Ekvw5p1PmXvXinQXMyowg@mail.gmail.com>
	<20111011103820.GF2138@amd.com>
	<CAK=WgbYOUZNX0OmRwZNO1mMG+3DZXwff+S60ESWixf04HOcbtw@mail.gmail.com>
	<20111014133510.GC2198@amd.com>
	<CAK=Wgbar+z_Nm1cDM4bJgrP5yWbjCsVBW=orfYwsZsT7uET8ng@mail.gmail.com>
Message-ID: <CAK=WgbaG5YNxESEhcW3Usgvx_9QLXT3OkNWXhgsaCDZ3yVZaVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2011 at 7:03 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> Btw, how have you tested this code?
>
> Of course. Every patch I send is always tested on...

*oops I thought you asked "Btw, have you tested this code?". I missed
the "how" part :)
