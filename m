From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 24 Oct 2018 14:09:33 +0300
Subject: [PATCH v2] staging: mt7621-dma: Add braces around else branches
In-Reply-To: <af4594cc-05c0-672c-d560-b50705ceaab3@gmail.com>
References: <20181023211142.GA2661@v> <20181024045653.GA2864@v>
 <af4594cc-05c0-672c-d560-b50705ceaab3@gmail.com>
Message-ID: <20181024110933.ys7obd7sze3a6mgk@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2018 at 12:45:44PM +0200, Matthias Brugger wrote:
> Hi Kiberly,
> 
> Thanks for adding all the emails in CC.
> I would encourage you for your next patch to distinguish between CC and TO.
> You should send your patch TO important maintainers in the get_maintainers.pl
> list (as default, to all of them). If there is someone you really want to look
> into the patch, then add him/her in TO as well.
> 

I normally just add the first person from get_maintainer.pl to the To:.
It's basically random I think.  The rest I put in the CC.  This is a
staging patch so no one is very picky.

There isn't a Fixes tag for this but if there were I add the person who
wrote the original patch to the To header.  Hopefully, they review
and Ack my patch.  I feel like that's very important.

regards,
dan carpenter
