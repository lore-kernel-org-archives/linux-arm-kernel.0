From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Sat, 30 May 2015 16:43:14 -0400
Subject: [linux-sunxi] [PATCH v2 0/6] Introduce Allwinner A33 support
In-Reply-To: <1432997706-20172-1-git-send-email-hdegoede@redhat.com>
References: <1432997706-20172-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAKON4OycC=ADUwFdJQJiAJ9tS6AJJ_GaoG8Tn5bNFx9jrxaoUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Is the A33 Lollipop SDK somewhere?

On Sat, May 30, 2015 at 10:55 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi Maxime,
>
> Here is a cleaned up series of Vishnu Patekar's A33 support. This should
> address all concerns raised during the posting of v1.
>
> I've tested that all peripherals declared in the shared sun8i-a23-a33.dtsi
> work on the A33 too, with the exception of the dma-controller. For the
> dma-controller I've compared the A23 vs A33 manual and the entire dma-
> controller description including the register description is bit for bit
> identical.
>
> This has been tested on a 7" Ippo Q8H v1.2 A23 tablet, a 7" Ippo Q8H v1.2
> A33 tablet and a 10" GA10H A33 tablet. The dts for the 10" tablet still
> needs some work wrt the lradc button voltages so that is not included
> in this set.
>
> Regards,
>
> Hans
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.



-- 
Jon Smirl
jonsmirl at gmail.com
