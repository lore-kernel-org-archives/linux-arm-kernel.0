From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 9 Jan 2015 14:25:01 -0800
Subject: [PATCH v4 5/5] tty/serial: Add Spreadtrum sc9836-uart driver
 support
In-Reply-To: <1417692860-18841-6-git-send-email-chunyan.zhang@spreadtrum.com>
References: <sc9836v4>
 <1417692860-18841-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1417692860-18841-6-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <20150109222501.GA10102@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 04, 2014 at 07:34:20PM +0800, Chunyan Zhang wrote:
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -247,4 +247,7 @@
>  /* MESON */
>  #define PORT_MESON	109
>  
> +/* SPRD SERIAL  */
> +#define PORT_SPRD       110

Please use a tab here, like all other entries have.
