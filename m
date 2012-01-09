From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 9 Jan 2012 17:46:21 +0100
Subject: [PATCH v2] atmel_lcdfb: fix usage of CONTRAST_CTR in
 suspend/resume
In-Reply-To: <1326126237-4355-1-git-send-email-nicolas.ferre@atmel.com>
References: <1307350251-5767-1-git-send-email-h.feurstein@gmail.com>
 <1326126237-4355-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20120109164621.GJ2854@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:23 Mon 09 Jan     , Nicolas Ferre wrote:
> From: Hubert Feurstein <h.feurstein@gmail.com>
> 
> An error was existing in the saving of CONTRAST_CTR register
> across suspend/resume.
> 
> Signed-off-by: Hubert Feurstein <h.feurstein@gmail.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: stable <stable@vger.kernel.org>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
