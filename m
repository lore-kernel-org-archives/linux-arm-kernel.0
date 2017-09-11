From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 11 Sep 2017 11:16:54 +0200
Subject: [PATCH 2/3] [media] s5p-mfc: Improve a size determination in
 s5p_mfc_alloc_memdev()
In-Reply-To: <003abb1f-4dc6-91ca-9d03-cae13dc4ff6f@users.sourceforge.net>
References: <482a6c92-a85e-0bcd-edf7-3c2f63ea74c5@users.sourceforge.net>
 <003abb1f-4dc6-91ca-9d03-cae13dc4ff6f@users.sourceforge.net>
 <CGME20170911091700epcas1p1bd85f95a6b776581ad4cd6f3108d09ba@epcas1p1.samsung.com>
Message-ID: <5b6fc74a-9927-cc1d-fd89-cd4578a14791@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2017 10:52 PM, SF Markus Elfring wrote:
> Replace the specification of a data structure by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring<elfring@users.sourceforge.net>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
