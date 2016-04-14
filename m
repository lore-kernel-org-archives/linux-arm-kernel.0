From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 14 Apr 2016 17:56:34 +0200
Subject: [PATCH] clk: sunxi: Use resource_size
In-Reply-To: <1460350383-7661-1-git-send-email-vaishali.thakkar@oracle.com>
References: <1460350383-7661-1-git-send-email-vaishali.thakkar@oracle.com>
Message-ID: <20160414155634.GP4005@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 10:23:03AM +0530, Vaishali Thakkar wrote:
> Use the function resource_size instaed of explicit computation.
> 
> Problem found using Coccinelle.
> 
> Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>

Applied, thanks !
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160414/b9093595/attachment.sig>
