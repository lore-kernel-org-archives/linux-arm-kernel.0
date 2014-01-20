From: phacht@linux.vnet.ibm.com (Philipp Hachtmann)
Date: Mon, 20 Jan 2014 09:39:48 +0100
Subject: [PATCH V3 2/2] mm/memblock: Add support for excluded memory areas
In-Reply-To: <902E09E6452B0E43903E4F2D568737AB0B9852BA@DFRE01.ent.ti.com>
References: <1389618217-48166-1-git-send-email-phacht@linux.vnet.ibm.com>
 <1389618217-48166-3-git-send-email-phacht@linux.vnet.ibm.com>
 <52D538FD.8010907@ti.com> <20140114195225.078f810a@lilie>
 <902E09E6452B0E43903E4F2D568737AB0B9852BA@DFRE01.ent.ti.com>
Message-ID: <20140120093948.0add11f4@lilie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Fri, 17 Jan 2014 18:08:13 +0000
schrieb "Strashko, Grygorii" <grygorii.strashko@ti.com>:

Hello Grygorii,

> > The current patch seems to be overly complicated.
> > The following patch contains only the nomap functionality without
> > any cleanup and refactoring. I will post a V4 patch set which will
> > contain this patch.

please see the V4 patch set I've sent to the list. There you will
clearly see that nothing is changed. No API is broken by the patch.
The patch only adds functionality.
Everything that worked before keeps working as before without any
changes needed in any arch's code.

Kind regards

Philipp
