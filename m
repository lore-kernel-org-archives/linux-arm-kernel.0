From: vkoul@kernel.org (Vinod)
Date: Fri, 25 May 2018 16:29:43 +0530
Subject: [PATCH v2 11/13] dmaengine: pxa: make the filter function internal
In-Reply-To: <20180524070703.11901-12-robert.jarzmik@free.fr>
References: <20180524070703.11901-1-robert.jarzmik@free.fr>
 <20180524070703.11901-12-robert.jarzmik@free.fr>
Message-ID: <20180525105943.GP26663@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24-05-18, 09:07, Robert Jarzmik wrote:
> As the pxa architecture and all its related drivers do not rely anymore
> on the filter function, thanks to the slave map conversion, make
> pxad_filter_fn() static, and remove it from the global namespace.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
