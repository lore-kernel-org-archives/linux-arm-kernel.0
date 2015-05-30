From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 30 May 2015 16:55:00 +0200
Subject: [PATCH v2 0/6] Introduce Allwinner A33 support
Message-ID: <1432997706-20172-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Here is a cleaned up series of Vishnu Patekar's A33 support. This should
address all concerns raised during the posting of v1.

I've tested that all peripherals declared in the shared sun8i-a23-a33.dtsi
work on the A33 too, with the exception of the dma-controller. For the
dma-controller I've compared the A23 vs A33 manual and the entire dma-
controller description including the register description is bit for bit
identical.

This has been tested on a 7" Ippo Q8H v1.2 A23 tablet, a 7" Ippo Q8H v1.2
A33 tablet and a 10" GA10H A33 tablet. The dts for the 10" tablet still
needs some work wrt the lradc button voltages so that is not included
in this set.

Regards,

Hans
