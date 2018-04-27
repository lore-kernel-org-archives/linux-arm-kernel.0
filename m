From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Apr 2018 17:55:53 +0100
Subject: [PATCH 1/1] arm64: To remove initrd reserved area entry from
 memblock
In-Reply-To: <CADYJ94e=gFhSF+tQ-1f0Dy61urHjG=UNoWYPq7bsT+-VTR1nDw@mail.gmail.com>
References: <CGME20180406045340epcas1p1ae6416dc25823212303c9109d125c018@epcas1p1.samsung.com>
 <1522990390-30804-1-git-send-email-chandan.vn@samsung.com>
 <ff125919-66f7-6658-e9b1-817188c1bdd9@redhat.com>
 <CADYJ94eQyN7dtnnVN_AF0VixaJh3x52068xYtq54hsS4BpdwFg@mail.gmail.com>
 <CADYJ94e=gFhSF+tQ-1f0Dy61urHjG=UNoWYPq7bsT+-VTR1nDw@mail.gmail.com>
Message-ID: <20180427165552.GC5286@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 10:30:49AM +0530, Chandan Vn wrote:
> May I know when this patch would be taken for merging?

Please can you send a new version, stating in the commit message that
this only affects accountinga and debugging, rather than plugging an
actual memory leak?

Cheers,

Will
