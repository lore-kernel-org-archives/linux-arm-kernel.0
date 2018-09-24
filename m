From: bp@alien8.de (Borislav Petkov)
Date: Mon, 24 Sep 2018 12:41:52 +0200
Subject: [PATCH v7 4/7] edac: synopsys: Add macro defines for ZynqMP DDRC
In-Reply-To: <DM6PR02MB5227D961C992C3BB6A4421B7C1170@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-5-git-send-email-manish.narani@xilinx.com>
 <20180924092226.GA20187@zn.tnic>
 <DM6PR02MB5227D961C992C3BB6A4421B7C1170@DM6PR02MB5227.namprd02.prod.outlook.com>
Message-ID: <20180924104152.GD20187@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2018 at 10:29:44AM +0000, Manish Narani wrote:
> > Is there some significance here or can they all be vertically aligned?
> Should I increase the alignment of the existing macros in the 'code
> formatting' patches? New macros will need an increased indentation.

If there is no significance to that different alignment, you probably
should so that it is all on one column.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
