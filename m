From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 04 Jun 2015 11:10:06 +0900
Subject: [PATCH 09/11] dma: pl330: fix wording in mcbufsz message
In-Reply-To: <14872fc6f86b7f4976d539b47a7899904cd954f6.1433364398.git.hramrach@gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
 <14872fc6f86b7f4976d539b47a7899904cd954f6.1433364398.git.hramrach@gmail.com>
Message-ID: <556FB37E.3000800@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.06.2015 06:26, Michal Suchanek wrote:
> The kernel is not trying to increase mcbufsz. It suggests you should try
> doing so. Also print the calculated required size of mcbufsz.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>

Looks good:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
