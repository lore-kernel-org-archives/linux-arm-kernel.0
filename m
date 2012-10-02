From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 2 Oct 2012 14:18:59 +0530
Subject: [PATCH v3] media: davinci: vpif: display: separate out subdev
 from output
In-Reply-To: <1348571509-4131-1-git-send-email-prabhakar.lad@ti.com>
References: <1348571509-4131-1-git-send-email-prabhakar.lad@ti.com>
Message-ID: <506AAA7B.1020308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/25/2012 4:41 PM, Prabhakar wrote:
> From: Lad, Prabhakar <prabhakar.lad@ti.com>
> 
> vpif_display relied on a 1-1 mapping of output and subdev. This is not
> necessarily the case. Separate the two. So there is a list of subdevs
> and a list of outputs. Each output refers to a subdev and has routing
> information. An output does not have to have a subdev.
> 
> The initial output for each channel is set to the fist output.
> 
> Currently missing is support for associating multiple subdevs with
> an output.
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.lad@ti.com>
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: Sekhar Nori <nsekhar@ti.com>

For the DaVinci platform changes:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
