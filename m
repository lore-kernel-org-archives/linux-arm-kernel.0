From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Mon, 14 Aug 2017 22:31:56 +0200
Subject: [PATCH 0/2] More s5p-jpeg fixes
In-Reply-To: <1502452201-17171-1-git-send-email-andrzej.p@samsung.com>
References: <1502191352-11595-1-git-send-email-andrzej.p@samsung.com>
 <CGME20170811115011eucas1p2d31daaa9e6f8d142291d9352ad5b732c@eucas1p2.samsung.com>
 <1502452201-17171-1-git-send-email-andrzej.p@samsung.com>
Message-ID: <df06d840-d0d2-4aa4-4490-152d020f6ef5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrzej,

Thanks for the patches.

On 08/11/2017 01:49 PM, Andrzej Pietrasiewicz wrote:
> Hi All,
> 
> The first patch in the series fixes decoding path,
> the second patch fixes encoding path. Please see
> appropriate commit messages.
> 
> Andrzej Pietrasiewicz (2):
>   media: s5p-jpeg: don't overwrite result's "size" member
>   media: s5p-jpeg: set w/h when encoding
> 
>  drivers/media/platform/s5p-jpeg/jpeg-core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

-- 
Best regards,
Jacek Anaszewski
