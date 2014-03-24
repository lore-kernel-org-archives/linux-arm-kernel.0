From: monstr@monstr.eu (Michal Simek)
Date: Mon, 24 Mar 2014 13:06:58 +0100
Subject: [PATCH v6 2/2] dma: Add Xilinx AXI Video Direct Memory Access
 Engine driver support
In-Reply-To: <CABb+yY13sheOvhVUkYNAO7t16egnPdf5x_fSvNuXVsU4E=W1Eg@mail.gmail.com>
References: <1395083192-3224-1-git-send-email-sthokal@xilinx.com>
 <1395083192-3224-3-git-send-email-sthokal@xilinx.com>
 <CABb+yY1z1Rr-EyJaeHQDb+thmKZVk5V93avokx6Z_EEuQFHyrw@mail.gmail.com>
 <CA+mB=1Lwq=Z3E+K7KTCgDKdmEQ8s5DMsAQVLVijdNPknNzx+SA@mail.gmail.com>
 <CAJe_Zhdnz+bdFiAqPgdH5hOTfzYUsoMyd0qpoWkeDAqqU+itSQ@mail.gmail.com>
 <53301023.8080301@monstr.eu>
 <CABb+yY13sheOvhVUkYNAO7t16egnPdf5x_fSvNuXVsU4E=W1Eg@mail.gmail.com>
Message-ID: <53301FE2.4080705@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/2014 12:02 PM, Jassi Brar wrote:
> On Mon, Mar 24, 2014 at 4:29 PM, Michal Simek <monstr@monstr.eu> wrote:
>> Hi Vinod,
>>
>> sorry for top posting.
>>
>> is there any chance to get this driver to the 3.15?
>> Or have you already closed your dma repo for new drivers?
>>
>> The driver should be in pretty good shape after long review.
>> From email below Srikanth got ACK from Jassi
>> and there should be a small fix which Srikanth will send in v7
>> which I hope will be the last version.
>>
> +1  Any change may come incrementally.
> 
> Btw, here's the ack
>    Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
> 

Ok. That's even better. The reason why I am asking for finishing
this is that we would like to start to pushing changes to
the media tree which depends on this driver.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140324/815b86ac/attachment.sig>
