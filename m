From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 20 Oct 2011 08:01:12 +0200
Subject: CMA v16 and DMA-mapping v13 patch series
Message-ID: <ADF13DA15EB3FE4FBA487CCC7BEFDF3622549EBE58@bssrvexch01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

It looks that the last patch series from me was not clearly described in terms
of their kernel base. Selecting a '-next' kernel as a base was not the best
idea. I'm really sorry for the confusion. I've rebased again these series and
prepared 3 new branches. Feel free to download and give them a try.

Here are the kernel trees with latest version of the patches, ready to use:

Linux v3.1-rc10 with CMA v16 (and a few fixes):
git://git.infradead.org/users/kmpark/linux-2.6-samsung 3.1-rc10-cma-v16

Linux v3.1-rc10 with DMA mapping v3 (with DMA-IOMMU integration):
git://git.infradead.org/users/kmpark/linux-2.6-samsung 3.1-rc10-dma-v3

Linux v3.1-rc10 with both CMA v16 and DMA-mapping v3:
git://git.infradead.org/users/kmpark/linux-2.6-samsung 3.1-rc10-cma-v16-dma-v3

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center



The above message is intended solely for the named addressee and may contain trade secret, industrial technology or privileged and confidential information otherwise protected under applicable law. Any unauthorized dissemination, distribution, copying or use of the information contained in this communication is strictly prohibited. If you have received this communication in error, please notify sender by email and delete this communication immediately.


Powy?sza wiadomo?? przeznaczona jest wy??cznie dla adresata niniejszej wiadomo?ci i mo?e zawiera? informacje b?d?ce tajemnic? handlow?, tajemnic? przedsi?biorstwa oraz informacje o charakterze poufnym chronione obowi?zuj?cymi przepisami prawa. Jakiekolwiek nieuprawnione ich rozpowszechnianie, dystrybucja, kopiowanie lub u?ycie informacji zawartych w powy?szej wiadomo?ci jest zabronione. Je?li otrzyma?e? powy?sz? wiadomo?? omy?kowo, uprzejmie prosz? poinformuj o tym fakcie drog? mailow? nadawc? tej wiadomo?ci oraz niezw?ocznie usu? powy?sz? wiadomo?? ze swojego komputera.
