From: ernestovm07@gmail.com (ernestovm07 at gmail.com)
Date: Mon, 13 Jun 2016 12:10:57 -0700 (PDT)
Subject: [PATCH v2 0/6] Introduce Allwinner A33 support
In-Reply-To: <1432997706-20172-1-git-send-email-hdegoede@redhat.com>
References: <1432997706-20172-1-git-send-email-hdegoede@redhat.com>
Message-ID: <8a9fe780-30c2-49eb-8158-a5825887c857@googlegroups.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El s?bado, 30 de mayo de 2015, 9:55:10 (UTC-5), Hans de Goede escribi?:
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

http://hp7g2.blogspot.com
