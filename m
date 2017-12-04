From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 4 Dec 2017 13:52:35 +0300
Subject: [PATCH] staging: vc04_services: Fix trivial style issues
In-Reply-To: <30cc7b48def470f1bec8d8d255044f4f220531ee.1512368114.git.sky@genki.is>
References: <30cc7b48def470f1bec8d8d255044f4f220531ee.1512368114.git.sky@genki.is>
Message-ID: <20171204105235.2nhmalxsd4uslesi@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 04, 2017 at 01:17:36AM -0500, Genki Sky wrote:
> In bcm2835-camera, handle the following checkpatch.pl types:
>   - EMBEDDED_FUNCTION_NAME
>   - MULTILINE_DEREFERENCE
>   - SPLIT_STRING
> 
> [ note: this is for Task 10 of http://eudyptula-challenge.org/ ]

Leave this part out or put it under the --- cut off.  We don't want it
in the final git log.

> 
> Signed-off-by: Genki Sky <sky@genki.is>

Split it up and resend.  Then it's a nice little cleanup.  It's cool
that checkpatch.pl started complaining about MULTILINE_DEREFERENCEs.

regards,
dan carpenter
