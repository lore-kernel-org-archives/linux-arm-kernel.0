From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Tue, 20 Nov 2012 12:29:29 +0530
Subject: [PATCH 065/493] i2c: remove use of __devexit_p
In-Reply-To: <1353349642-3677-65-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-65-git-send-email-wfp5p@virginia.edu>
Message-ID: <CAM=Q2ct2tzxV70CZ1ua8B-jSPFugDYTQJ3T6z7StKT1m3F-VsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 11:50 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
>
 Reviewed-by: Shubhrajyoti D <shubhrajyoti@ti.com>
