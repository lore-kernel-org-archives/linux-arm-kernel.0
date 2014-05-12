From: pintu.k@outlook.com (Pintu Kumar)
Date: Mon, 12 May 2014 15:12:41 +0530
Subject: Questions regarding DMA buffer sharing using IOMMU
Message-ID: <BAY169-W12541AD089785F8BFBD4E26EF350@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,?
I have some queries regarding IOMMU and CMA buffer sharing.?
We have an embedded linux device (kernel 3.10, RAM: 256Mb) in which camera and codec supports IOMMU but the display does not support IOMMU.?
Thus for camera capture we are using iommu buffers using ION/DMABUF. But for all display rendering we are using CMA buffers.?
So, the question is how to achieve buffer sharing (zero-copy) between Camera and Display using only IOMMU??
Currently we are achieving zero-copy using CMA. And we are exploring options to use IOMMU.?
Now we wanted to know which option is better? To use IOMMU or CMA??
If anybody have come across these design please share your thoughts and results.?


Thank You!?
Regards,?
Pintu

 		 	   		  
