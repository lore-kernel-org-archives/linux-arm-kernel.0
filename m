From: bp@alien8.de (Borislav Petkov)
Date: Fri, 15 Apr 2016 23:46:18 +0200
Subject: [PATCH] Add EDAC peripheral init functions & Ethernet EDAC.
In-Reply-To: <5711087A.8050501@opensource.altera.com>
References: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
 <20160414143501.GA25212@rob-hp-laptop>
 <20160415064042.330406ab.m.chehab@samsung.com>
 <5711087A.8050501@opensource.altera.com>
Message-ID: <20160415214618.GB4545@cz.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2016 at 10:27:54AM -0500, Thor Thayer wrote:
> I'll update this patch to only count errors.

... and also think about what that counting is going to bring. If it is
only going to be there to show how many network errors happened and we
can't do anything about it except stare at that number, then adding all
that code is probably waste of time an electrons...

I'm just sayin'.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
