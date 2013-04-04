From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 4 Apr 2013 14:50:13 +0530
Subject: [PATCH v7 2/2] ARM: davinci: dm355 EVM: add support for VPBE
 display
In-Reply-To: <1364908504-14232-3-git-send-email-prabhakar.csengg@gmail.com>
References: <1364908504-14232-1-git-send-email-prabhakar.csengg@gmail.com>
 <1364908504-14232-3-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <515D45CD.6000407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/2/2013 6:45 PM, Prabhakar lad wrote:
> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> 
> add support for V4L2 video display to DM355 EVM.
> Support for SD modes is provided, along with Composite
> output
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Looks good. Since you mentioned that you will take this through media
tree to manage driver dependencies, please add:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
