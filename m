From: shijie.huang@arm.com (Huang Shijie)
Date: Tue, 18 Aug 2015 11:36:55 +0800
Subject: [PATCH 1/3] Honor ACPI _CCA attribute setting
In-Reply-To: <55CDF74C.3050703@arm.com>
References: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com>
 <1439416290-21228-2-git-send-email-jeremy.linton@arm.com>
 <55CD4832.7070301@amd.com> <55CDF74C.3050703@arm.com>
Message-ID: <20150818033655.GB9990@free64-pc.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 09:12:28AM -0500, Jeremy Linton wrote:
> Hello Suravee,
> 
> On 08/13/2015 08:45 PM, Suravee Suthikulpanit wrote:
> > On 8/13/15 04:51, Jeremy Linton wrote:
> >> ACPI configurations can now mark devices as noncoherent,
> >> support that choice.
> >
> > This change was in my earlier revisions for the original patch series to
> > add ACPI CCA support. At the time, this was pushed back since we were
> > not sure whether this would be a useful case, and whether such hardware
> > exists.
> 
> Yes, I was made aware of that conversation during the review here.
> 
> Basically, the ARM Juno development platform has a mix of coherent and 
> noncoherent devices. The EHCI being one of the primary noncoherent 
> peripherals. Without which, the usefulness of the platform for 
> developing with an ACPI kernel is limited.
> 
Tesed-by: Huang Shijie <shijie.huang@arm.com>
