From: bp@alien8.de (Borislav Petkov)
Date: Mon, 8 Oct 2018 20:03:38 +0200
Subject: [PATCH v8 02/10] edac: synopsys: Rename the static functions to
 a shorter name
In-Reply-To: <DM6PR02MB52274CC51BE196CF18C97834C1E60@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
 <1538667328-9465-3-git-send-email-manish.narani@xilinx.com>
 <20181004203540.GD5149@zn.tnic>
 <DM6PR02MB52274CC51BE196CF18C97834C1E60@DM6PR02MB5227.namprd02.prod.outlook.com>
Message-ID: <20181008180338.GB5919@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2018 at 01:45:28PM +0000, Manish Narani wrote:
> >  /**
> > - * synps_edac_get_eccstate - Return the controller ecc enable/disable status
> > - * @base:	Pointer to the ddr memory controller base address
> > + * get_ecc_state - Return the controller ECC enable/disable status
> 
> Nit: ecc --> ECC correction can be moved to Comments correction patch. Minor. Can keep it here too. 
> 

All fixed except this one - this one can remain here because the patch
is touching the line anyway.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
