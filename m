From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Dec 2014 23:12:24 -0800
Subject: [PATCH v6 0/8] Introduce automatic DMA configuration for IOMMU
 masters
In-Reply-To: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
Message-ID: <CAOesGMg9BpL3AyDjuAvH_H5fOm-uga+_CZuJZ5p8zpHpJLg0qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 1, 2014 at 8:57 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hello again,
>
> This is version 6 of the patches previously posted here:
>
>   RFCv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/283023.html
>   RFCv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/283752.html
>   RFCv3: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/287031.html
>   RFCv4: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/302711.html
>      v5: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/307213.html
>
> The only change since v5 is the addition of acks from various maintainers.
>
> Now that the ARM bits have rmk's ack and the IOMMU bits have joro's ack,
> I think this is good for merging via the arm-soc tree.
>
> Please let me know if a pull request would be preferable.


Hi,

Yes, please collect the acks from the discussion in the last day or so
and send a pull request (and include Robin's patch, obviously).


-Olof
