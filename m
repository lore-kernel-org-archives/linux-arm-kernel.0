From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 24 Jan 2017 16:10:57 +0530
Subject: [PATCH v2] arm: davinci: Make the usb20 clock available to PM
 runtime
In-Reply-To: <20170124103226.15377-1-abailon@baylibre.com>
References: <20170124103226.15377-1-abailon@baylibre.com>
Message-ID: <22d793a6-71db-cbf4-2f76-6539015e285b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 January 2017 04:02 PM, Alexandre Bailon wrote:
> Add usb20 to the list of clock supported by PM runtime.

Patch description does not match contents. You should rather talk about:
since USB20 subsystem uses just one clock, there is no need of a con_id,
so we are using NULL.

Also, "ARM: " prefix should be capitalized .

> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Suggested-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
