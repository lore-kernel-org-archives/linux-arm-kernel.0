From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 11 Sep 2017 11:14:33 +0200
Subject: [PATCH 1/3] [media] s5p-mfc: Delete an error message for a
 failed memory allocation in s5p_mfc_probe()
In-Reply-To: <ff8f7dcd-c3e8-2a12-c0db-997b514f5d94@users.sourceforge.net>
References: <482a6c92-a85e-0bcd-edf7-3c2f63ea74c5@users.sourceforge.net>
 <ff8f7dcd-c3e8-2a12-c0db-997b514f5d94@users.sourceforge.net>
 <CGME20170911091439epcas1p3f8b62f55cae4255d250b1fe990fbf1ff@epcas1p3.samsung.com>
Message-ID: <ccf6b04a-6e8a-231c-f456-0b37ba350acc@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2017 10:51 PM, SF Markus Elfring wrote:
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring<elfring@users.sourceforge.net>

Could you make the commit summary shorter, to keep it below 70
characters [1]? With that changed feel free to add

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

--
Regards,
Sylwester

[1] Documentation/process/submitting-patches.rst
