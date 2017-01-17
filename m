From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Tue, 17 Jan 2017 13:18:35 +0200
Subject: [PATCH v2 1/3] spi: pxa2xx: Factor out handle_bad_msg
In-Reply-To: <776c72d3de4b75ff0a8b91791740389950d8abe8.1484592296.git.jan.kiszka@siemens.com>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <776c72d3de4b75ff0a8b91791740389950d8abe8.1484592296.git.jan.kiszka@siemens.com>
Message-ID: <fb68555c-ec49-5f08-5b26-e6776855b3c6@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2017 08:44 PM, Jan Kiszka wrote:
> As suggested by Andy Shevchenko: Decouple this corner cause from the
> general handling logic in ssp_int.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/spi/spi-pxa2xx.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
