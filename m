From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 31 Jul 2018 05:04:28 -0700
Subject: [PATCH 5/6] arm: enable RapidIO menu in Kconfig
In-Reply-To: <20180730225035.28365-6-acolin@isi.edu>
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-6-acolin@isi.edu>
Message-ID: <20180731120428.GA5696@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2018 at 06:50:33PM -0400, Alexei Colin wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index afe350e5e3d9..602a61324890 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1278,6 +1278,8 @@ config PCI_HOST_ITE8152
>  
>  source "drivers/pci/Kconfig"
>  
> +source "drivers/rapidio/Kconfig"

Please include this from drivers/Kconfig instead of enabling it
for a completely random set of architectures.
