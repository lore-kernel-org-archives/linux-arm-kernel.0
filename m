From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 19 Dec 2012 16:57:31 +0000 (UTC)
Subject: [PATCH] ARM: OMAP4: PRM: Correct wrong instance usage for reading
 reset sources
In-Reply-To: <1355911588-21977-2-git-send-email-ivan.khoronzhuk@ti.com>
References: <1355911588-21977-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1355911588-21977-2-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <alpine.DEB.2.00.1212191657260.16873@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Dec 2012, Ivan Khoronzhuk wrote:

> To read reset sources registers we have to use PRM_DEVICE_INST
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>

Thanks, queued for v3.8-rc fixes.


- Paul
