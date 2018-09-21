From: bp@alien8.de (Borislav Petkov)
Date: Fri, 21 Sep 2018 11:15:32 +0200
Subject: [PATCH v7 2/7] edac: synps: Add platform specific structures for
 ddrc controller
In-Reply-To: <20180921090721.GB30439@nazgul.tnic>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-3-git-send-email-manish.narani@xilinx.com>
 <20180918075522.GC22202@nazgul.tnic>
 <DM6PR02MB5227F5B1B329C903BA64A27CC11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
 <20180919111553.GA9140@nazgul.tnic>
 <DM6PR02MB52279753E7FD04587393DC08C11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
 <20180921090721.GB30439@nazgul.tnic>
Message-ID: <20180921091532.GC30439@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's more:

I said:

> > @@ -370,12 +398,12 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)

> That function returns 0 unconditionally. Make it a void in a prepatch.

But you've lumped this change together with a bunch more. Maybe my
request wasn't clear so let me rephrase it:

That function returns 0 unconditionally. Make it a void in a *separate* prepatch.

Ok?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
