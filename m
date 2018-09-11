From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 11 Sep 2018 20:56:16 +0200
Subject: [PATCH v3 2/2] mtd: spi-nor: parse SFDP Sector Map Parameter Table
In-Reply-To: <20180911154007.17195-3-tudor.ambarus@microchip.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
 <20180911154007.17195-3-tudor.ambarus@microchip.com>
Message-ID: <dbfc2491-5fd8-eec9-650f-183c63f9963b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2018 05:40 PM, Tudor Ambarus wrote:
> Add support for the SFDP (JESD216B) Sector Map Parameter Table. This
> table is optional, but when available, we parse it to identify the
> location and size of sectors within the main data array of the
> flash memory device and to identify which Erase Types are supported by
> each sector.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>


-- 
Best regards,
Marek Vasut
