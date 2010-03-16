From: martinwguy@gmail.com (Martin Guy)
Date: Tue, 16 Mar 2010 23:52:17 +0000
Subject: [spi-devel-general] [PATCH 2/3] ep93xx: added chip revision
	reading function
In-Reply-To: <0D753D10438DA54287A00B02708426976368534001@AUSP01VMBX24.collaborationhost.net>
References: <cover.1268669236.git.mika.westerberg@iki.fi>
	<3d93e748eb068963a9378b454ba9cd117cbbc737.1268669236.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B027084269763685332EF@AUSP01VMBX24.collaborationhost.net>
	<0D753D10438DA54287A00B02708426976368534001@AUSP01VMBX24.collaborationhost.net>
Message-ID: <56d259a01003161652n40abcb8s115fd8d054118c82@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/16/10, H Hartley Sweeten <hartleys@visionengravers.com> wrote:
> On Monday, March 15, 2010 11:06 AM, H Hartley Sweeten wrote:
>  > On Monday, March 15, 2010 9:26 AM, Mika Westerberg wrote:
>  >> + * %EP93XX_CHIP_REV_A
>  >> + * %EP93XX_CHIP_REV_B
>  >> + * %EP93XX_CHIP_REV_C
>  >> + * %EP93XX_CHIP_REV_D0
>  >> + * %EP93XX_CHIP_REV_D1
>  >> + * %EP93XX_CHIP_REV_E0
>  >> + * %EP93XX_CHIP_REV_E1
>  >> + * %EP93XX_CHIP_REV_E2

Come to that, I've never heard of revisions A B or C.
Even D0 now is so rare as to be nonexistent.
I have a very early EP board, the Armadillo-9. and even that is E0, so
I'd certainly drop [ABC] unless you have some evidence of their
existence

     M
