From: dtor@vmware.com (Dmitry Torokhov)
Date: Mon, 26 Nov 2012 09:37:35 -0800
Subject: [Pv-drivers] [PATCH 192/493] scsi: remove use of __devinit
In-Reply-To: <1353349642-3677-192-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-192-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121126173735.GC11127@dtor-ws.eng.vmware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 01:22:21PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
> 

...

>  drivers/scsi/vmw_pvscsi.c                 |  6 +-

For vmw_pvscsi:

Acked-by: Dmitry Torokhov <dtor@vmware.com>

Thanks,
Dmitry
