From: dtor@vmware.com (Dmitry Torokhov)
Date: Mon, 26 Nov 2012 09:36:52 -0800
Subject: [Pv-drivers] [PATCH 097/493] scsi: remove use of __devexit_p
In-Reply-To: <1353349642-3677-97-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-97-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121126173651.GB11127@dtor-ws.eng.vmware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 01:20:46PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
> 

...

>  drivers/scsi/vmw_pvscsi.c                 | 2 +-

For vmw_pvscsi:
 
Acked-by: Dmitry Torokhov <dtor@vmware.com>

Thanks,
Dmitry
