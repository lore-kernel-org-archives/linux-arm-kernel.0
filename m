From: balbi@ti.com (Felipe Balbi)
Date: Fri, 19 Nov 2010 14:53:53 +0200
Subject: [PATCH v3 5/5] OMAP: mailbox: add notification support for
	multiple readers
In-Reply-To: <AANLkTinVf8--zmGa7svapcVpEp2BPXf33DtdruLtoJx5@mail.gmail.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	<1290107742-16760-6-git-send-email-h-kanigeri2@ti.com>
	<20101119085007.GK6446@legolas.emea.dhcp.ti.com>
	<AANLkTimSxGZufLk1RzQuBSg2vBF1p9BXFP8abVZVoLFs@mail.gmail.com>
	<20101119120938.GN2329@legolas.emea.dhcp.ti.com>
	<AANLkTinVf8--zmGa7svapcVpEp2BPXf33DtdruLtoJx5@mail.gmail.com>
Message-ID: <20101119125353.GB5818@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hari,

On Fri, Nov 19, 2010 at 06:29:39AM -0600, Kanigeri, Hari wrote:
>How do you know that a response is received for a particular sender ?

think of it as FIFO. So the first completed message is the first in your
list of requests. Ain't that easy ? :-)

>By reading mailbox payload or by reading some shared memory ? I think
>this itself would constitute building up protocol in mailbox driver.

I believe you're thinking too complicated :-p

>I fully agree with you about common framework, and the proposed
>solution for the common IPC framework is Syslink. This was discussed
>during the recent LPC meeting to come up with a common IPC framework
>that is currently missing in Kernel.
>I can share with you the details if you are interested.

Don't bother, I know all I wanted to know so far :-p

>As I said if some one does that then it is a misuse on their part :).
>The messages should be routed through IPC driver. And let's not forget
>the main motivation of this patch as well.

Still it doesn't the fact that currently you allow for that. There are
malware writers everywhere. But hey, it would be cool to have mailbox
appear on securityfocus.com :-p

-- 
balbi
