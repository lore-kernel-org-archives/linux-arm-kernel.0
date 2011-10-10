From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 11 Oct 2011 00:01:06 +0200
Subject: [PATCH v3 1/6] iommu/core: split mapping to page sizes as
	supported by the hardware
In-Reply-To: <CAK=WgbYR_qx53Z7s3R=q29KYo8ebYCH9H9=2OrrWXWMv6=-iOQ@mail.gmail.com>
References: <1316195506-9777-1-git-send-email-ohad@wizery.com>
	<1316195506-9777-2-git-send-email-ohad@wizery.com>
	<20110927100505.GH2138@amd.com>
	<CAK=WgbahwY+7Ux-RjW2Tw9WBSwZnYuTMZ2NQASWyOXQ3zF6qFg@mail.gmail.com>
	<20110927131222.GL2138@amd.com>
	<CAK=WgbYG2tpMJ2SikZhm=R9j5kQ6Hm8CGg=q1bko3idzF53Q3Q@mail.gmail.com>
	<20110927181438.GM2138@amd.com>
	<CAK=WgbbNs5fWHDEputZ=jzU5YN0sn0tf6AETkcsoq_Jbvc2XgQ@mail.gmail.com>
	<20111010094738.GW2138@amd.com>
	<CAK=WgbZ7Wyax1yfS1jSXw9OdwMtxxidwLO8PTsNUXX9CWzmVrw@mail.gmail.com>
	<20111010153609.GB2138@amd.com>
	<CAK=WgbYR_qx53Z7s3R=q29KYo8ebYCH9H9=2OrrWXWMv6=-iOQ@mail.gmail.com>
Message-ID: <CAK=WgbbXpqfrYYU4Or_q_ZtYzF9dH41hT+zXhB9-4pKjYFjK8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Mon, Oct 10, 2011 at 5:36 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
>> The master branch is best to base your patches on for generic work.

It looks like the master branch is missing something like this:
