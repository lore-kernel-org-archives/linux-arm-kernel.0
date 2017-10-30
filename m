From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Mon, 30 Oct 2017 15:44:13 +0200
Subject: [PATCH] media: atmel-isc: Fix clock ID for clk_prepare/unprepare
In-Reply-To: <20171030004650.15571-1-wenyou.yang@microchip.com>
References: <20171030004650.15571-1-wenyou.yang@microchip.com>
Message-ID: <20171030134413.swyju4ob5x4vaz66@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 08:46:50AM +0800, Wenyou Yang wrote:
> Fix the clock ID to do the runtime pm should be ISC_ISPCK,
> instead of ISC_MCK in clk_prepare(), clk_unprepare() and
> isc_clk_is_enabled().
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@microchip.com>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi
