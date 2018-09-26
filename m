From: scott.branden@broadcom.com (Scott Branden)
Date: Tue, 25 Sep 2018 17:31:13 -0700
Subject: [PATCH v3 0/2] staging: bcm2835-camera: Clean up completed TODO
In-Reply-To: <20180925083401.22533-4-qader.aymen@gmail.com>
References: <20180924233426.32609-1-qader.aymen@gmail.com>
 <20180925083401.22533-1-qader.aymen@gmail.com>
 <20180925083401.22533-4-qader.aymen@gmail.com>
Message-ID: <51a078ef-41d2-d631-7f38-f752095ca117@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks good now.


On 18-09-25 01:33 AM, Aymen Qader wrote:
> Update the bcm2835-camera driver to remove a TODO and an unused header
> include. These were made unnecessary in
>
> commit 7e8dbea41032 ("staging: bcm2835-camera: Remove explicit cache
> flush operations")
>
> Aymen Qader (2):
>    staging: bcm2835-camera: Update TODO
>    staging: bcm2835-camera: Remove unused header
>
> --
> v2: Make commit message clearer
> v3: Separate patch into two, clean up commit messages
>
>   drivers/staging/vc04_services/bcm2835-camera/TODO         | 6 ------
>   drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 1 -
>   2 files changed, 7 deletions(-)
>
Acked-by: Scott Branden <scott.branden@broadcom.com>
