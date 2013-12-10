From: dinguyen@altera.com (Dinh Nguyen)
Date: Tue, 10 Dec 2013 09:51:28 -0600
Subject: dw_apb_timer compatible string change
In-Reply-To: <20131209104547.GC705@tarshish>
References: <20131209104547.GC705@tarshish>
Message-ID: <1386690688.6211.3.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Mon, 2013-12-09 at 12:45 +0200, Baruch Siach wrote:
> Hi Dinh,
> 
> In commit 620f5e1cbf (dts: Rename DW APB timer compatible strings) you changed 
> the DesignWare APB timer documented compatible string to "dw-apb-timer", and 
> deprecated the old ones. This commit went into v3.12 through the ARM SoC tree. 
> The driver itself, however, doesn't seems to have been updated to recognize 
> this newly documented compatible string as of v3.13-rc3.
> 
> Do you know whether there is a patch fixing the driver in some patch queue?

It is is Daniel's tree, and hopefully, it should be going into
3.13-fixes soon.

Dinh
> 
> baruch
> 
