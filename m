From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 19 Apr 2016 17:30:00 -0500
Subject: [PATCH 0/6 v2] of: Implement iterator for phandles
In-Reply-To: <1459784962-9808-1-git-send-email-joro@8bytes.org>
References: <1459784962-9808-1-git-send-email-joro@8bytes.org>
Message-ID: <CAL_Jsq+ybv2=sNW_FWBOnThuh_Lfv32jwYC++vxoy2CxqNw2ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 4, 2016 at 10:49 AM, Joerg Roedel <joro@8bytes.org> wrote:
> Hi,
>
> here is a new version of the implementation of the iterator
> over phandles concept which Rob Herring suggested to me some
> time ago. My approach is a little bit different from what
> the diff showed back then, but it gets rid of the allocation
> and 'struct of_phandle_args' misuse.
>
> I also converted the arm-smmu driver to make use of the
> iterator. The resulting kernel boots on my AMD Seattle
> system and fixes the warning triggered there. The patches
> now also pass all dt-unittests in my kvm environment.
>
> Patches are based on v4.6-rc2

Series now applied.

Rob
