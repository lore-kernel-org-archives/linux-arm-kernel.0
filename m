From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 13 Sep 2011 13:19:56 +0300
Subject: [PATCH 1/3] iommu/core: add fault reporting mechanism
In-Reply-To: <20110913100034.GJ11701@amd.com>
References: <1315421604-12286-1-git-send-email-ohad@wizery.com>
	<20110912160252.GE11701@amd.com>
	<CAK=WgbZCDsBk+dueKfAX3ewsvqEnVDN+jW_ftW+BDKnayunOwA@mail.gmail.com>
	<20110913100034.GJ11701@amd.com>
Message-ID: <CAK=WgbZ0TGDevR+HP=KmE1DDanSwCxOnpNf_wn2UfRATALJHcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2011 at 1:00 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> For now I think it is the best to remove this IOMMU_ERROR thing. It is
> inherent to the function call already. When a real use-case comes up we
> can easily add it later.

I'm fine with this, will post an update.

Thanks,
Ohad.
