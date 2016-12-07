From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 8 Dec 2016 00:50:48 +0200
Subject: [PATCH v2] ARM: dts: lpc32xx: add pwm-cells to base dts file
In-Reply-To: <1481139047-13166-1-git-send-email-slemieux.tyco@gmail.com>
References: <1481139047-13166-1-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <3cbc7c24-0a0a-d8a0-ebdb-722cf9d2eb02@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

On 12/07/2016 09:30 PM, Sylvain Lemieux wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
> 
> There is no need to define the "pwm-cells" in the board
> specific dts file; move the entry to the base dts file.
> 
> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> ---

thank you for the change,

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
With best wishes,
Vladimir
