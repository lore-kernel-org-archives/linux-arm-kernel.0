From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 4 Dec 2017 08:31:52 +0100
Subject: [PATCH] staging: vc04_services: Fix trivial style issues
In-Reply-To: <30cc7b48def470f1bec8d8d255044f4f220531ee.1512368114.git.sky@genki.is>
References: <30cc7b48def470f1bec8d8d255044f4f220531ee.1512368114.git.sky@genki.is>
Message-ID: <20171204073152.GB19596@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 04, 2017 at 01:17:36AM -0500, Genki Sky wrote:
> In bcm2835-camera, handle the following checkpatch.pl types:
>   - EMBEDDED_FUNCTION_NAME
>   - MULTILINE_DEREFERENCE
>   - SPLIT_STRING
> 
> [ note: this is for Task 10 of http://eudyptula-challenge.org/ ]
> 
> Signed-off-by: Genki Sky <sky@genki.is>
> ---
>  .../vc04_services/bcm2835-camera/bcm2835-camera.c  | 23 +++++++++-------------
>  .../vc04_services/bcm2835-camera/mmal-vchiq.c      |  7 +++----
>  2 files changed, 12 insertions(+), 18 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
