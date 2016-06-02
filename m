From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Jun 2016 11:35:38 +0200
Subject: [PATCH 1/3] dt-bindings: add DT binding for the Aardvark PCIe
 controller
In-Reply-To: <1464858585-10963-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1464858585-10963-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <33469694.MLbpCUJe2G@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 2, 2016 11:09:43 AM CEST Thomas Petazzoni wrote:
> +               ranges = <0x82000000 0 0xe8000000   0 0xe8000000 0 0x1000000 /* Port 0 MEM */
> +                         0x81000000 0 0xe9000000   0 0xe9000000 0 0x10000>; /* Port 0 IO*/
> 

Any reason for not having a 64-bit MEM prefetchable area in the example?
Does the host not support that?

	Arnd
