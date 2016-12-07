From: stillcompiling@gmail.com (Joshua Clayton)
Date: Wed, 7 Dec 2016 13:29:29 -0800
Subject: [PATCH v5 3/3] fpga manager: Add cyclone-ps-spi driver for Altera
 FPGAs
In-Reply-To: <20161207222127.23f6b8b4@crub>
References: <cover.1481139171.git.stillcompiling@gmail.com>
 <1778a82d1989d13919b24e47fa09eeb56b2cb8e5.1481139171.git.stillcompiling@gmail.com>
 <20161207222127.23f6b8b4@crub>
Message-ID: <6e33619c-e8a4-e372-04ab-d03c379cbfa0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Anatolij,
Thanks for the quick look and response.
I guess I should have rebased before submitting.
I just realized I also forgot to send this patch series to
the newly minted FPGA Manager mailing list. V6 coming soon :)

On 12/07/2016 01:21 PM, Anatolij Gustschin wrote:
> On Wed,  7 Dec 2016 13:04:40 -0800
> Joshua Clayton stillcompiling at gmail.com wrote:
> ...
>> +static int cyclonespi_write_init(struct fpga_manager *mgr, u32 flags,
>> +				 const char *buf, size_t count)
> there is a minor API change in linux-next [1]. struct fpga_image_info *
> is passed instead of u32 flags. I assume this will be merged soon, so
> please prepare this driver accordingly.
>
> ...
Ah. Thanks.

>> +static int cyclonespi_write_complete(struct fpga_manager *mgr, u32 flags)
> same here.
OK.
>
> [1] http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/fpga?id=1df2865f8dd9d56cb76aa7aa1298921e7bece2af
>
> --
> Anatolij
Joshua
