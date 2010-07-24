From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 24 Jul 2010 14:24:59 -0600
Subject: =?US-ASCII?Q?Re=3A_=5Blinux-pm=5D_=5BPATCH/RFC=5D_Runtime_PM=3A_ARM=3A?=
	=?US-ASCII?Q?_subarch-specific_=09extensions_of_pdev=5Farchdata?=
In-Reply-To: <AANLkTinBqc11oE2SOmvXbFHmlgvZ21LngXNWkSHiJmRK@mail.gmail.com>
References: <1253670648-28610-1-git-send-email-khilman@deeprootsystems.com>
	<f17812d70909222153y4a0e4fc2n496ea2e6caaac847@mail.gmail.com>
	<19129.63264.653666.70492@pilspetsen.it.uu.se>
	<4ABAAF1D.6090907@deeprootsystems.com>
	<f17812d70909231630i20f64328k8d604c3436094b85@mail.gmail.com>
	<87k4yhagv4.fsf@deeprootsystems.com>
	<AANLkTinBqc11oE2SOmvXbFHmlgvZ21LngXNWkSHiJmRK@mail.gmail.com>
Message-ID: <34dc79dc-0868-4401-9fa5-c7134f6d4485@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



"Magnus Damm" <magnus.damm@gmail.com> wrote:

>On Tue, Oct 27, 2009 at 8:13 AM, Kevin Hilman
><khilman@deeprootsystems.com> wrote:
>> Eric Miao <eric.y.miao@gmail.com> writes:
>>> On Thu, Sep 24, 2009 at 7:28 AM, Kevin Hilman
>>> <khilman@deeprootsystems.com> wrote:
>>>> Mikael Pettersson wrote:
>>>>> Eric Miao writes:
>>>>> ?> On Wed, Sep 23, 2009 at 9:50 AM, Kevin Hilman
>>>>> ?> <khilman@deeprootsystems.com> wrote:
>>>>> ?> > On ARM platforms, power management can be very platform specific.
>>>>> ?> > This patch allows ARM subarches to extend the platform_device
>>>>> ?> > pdev_archdata for each subarch by creating a new struct pdev_machdata
>>>>> ?> > and allowing each subarch to customize it as needed.
>
>[snip]
>
>> OK, after no further comments, sending this patch to the patch system.
>
>Hi Kevin,
>
>Thanks for your work on this. I found this patch marked as superseeded
>in the tracker here:
>
>http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5773/1
>
>I'd now like to use struct pdev_archdata myself on mach-shmobile, so
>almost a year later I wonder why this patch didn't make it.
>
>I realize that you use struct omap_device instead of struct
>pdev_archdata. I prefer not to wrap if possible. This because I'd like
>to reuse already existing drivers and PM code with the SuperH
>architecture.
>
>Do you remember what happened with this patch?

I don't have all the details in front of me because I'm on my phone, but I advised against pdev_archdata because it is multiplatform-unfriendly.

g.
-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
