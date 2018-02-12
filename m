From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 12 Feb 2018 10:30:25 -0800
Subject: [PATCH] irqchip: Remove hashed address printing
In-Reply-To: <20180212021812.3882-1-jaedon.shin@gmail.com>
References: <20180212021812.3882-1-jaedon.shin@gmail.com>
Message-ID: <20e9fd4b-ef57-effa-26b6-e0db2b584735@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2018 06:18 PM, Jaedon Shin wrote:
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> pointers are being hashed when printed. Displaying the virtual memory at
> bootup time is not helpful. so delete the prints.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks Jaedon!
-- 
Florian
