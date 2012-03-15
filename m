From: kumarrav@codeaurora.org (Ravi Kumar V)
Date: Thu, 15 Mar 2012 23:27:51 +0530
Subject: [PATCH v3 2/2] DMAEngine: Add DMAEngine driver based on old MSM
 DMA APIs
In-Reply-To: <CAPDArRLs23VDJSWpX8xJsXfn+_SV2FcyzLYBF9UAxf=Rv9svGQ@mail.gmail.com>
References: <1331548364-27845-1-git-send-email-kumarrav@codeaurora.org>
 <20120312201421.GA3459@fifo99.com>
 <CAPDArRLs23VDJSWpX8xJsXfn+_SV2FcyzLYBF9UAxf=Rv9svGQ@mail.gmail.com>
Message-ID: <4F622D9F.1070101@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/13/2012 4:27 PM, Shantanu Gupta wrote:
> Any info available(publicly) on so as to what all chipsets have this
> capability ?

This is DMA engine driver for "Application Data Mover(ADM)" which in one 
type of DMA device in most of the Qualcomm processors like snapdragon.

>
> On Tue, Mar 13, 2012 at 1:44 AM, Daniel Walker <dwalker@fifo99.com
> <mailto:dwalker@fifo99.com>> wrote:
>
>     On Mon, Mar 12, 2012 at 04:02:44PM +0530, Ravi Kumar V wrote:
>      > Add DMAEngine based driver using the old MSM DMA APIs internally.s
>
>     What do you mean by this?
>
>      > The benefit of this approach is that not all the drivers
>      > have to get converted to DMAEngine APIs simultaneosly while
>      > both the drivers can stay enabled in the kernel. The client
>      > drivers using the old MSM APIs directly can now convert to
>      > DMAEngine one by one.
>
>     Which drivers?
>
>     Daniel
>     --
>     To unsubscribe from this list: send the line "unsubscribe
>     linux-arm-msm" in
>     the body of a message to majordomo at vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>     More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>


-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
