From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 13 Mar 2013 18:48:34 +0100
Subject: [PATCH] pinctrl: mvebu: prevent walking off the end of group array
In-Reply-To: <1363196155-1620-1-git-send-email-jason@lakedaemon.net>
References: <1362872371.3690.106.camel@shinybook.infradead.org>
 <1363196155-1620-1-git-send-email-jason@lakedaemon.net>
Message-ID: <5140BBF2.4050309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2013 06:35 PM, Jason Cooper wrote:
> From: David Woodhouse<dwmw2@infradead.org>
>
> While investigating (ab)use of krealloc, David found this bug.  It's
> unlikely to occur, but now we detect the condition and error out
> appropriately.
>
> Signed-off-by: David Woodhouse<David.Woodhouse@intel.com>
> Signed-off-by: Jason Cooper<jason@lakedaemon.net>
> ---
> David, please double check that this is as you intended.  I had to hand-jam it in due to some peculiarities on my side.
>

Jason,

thanks for preparing that patch. I ll test (and Ack) asap but that will not be
before this weekend. If Thomas and Andrew ack it before me, consider it good.

Sebastian
