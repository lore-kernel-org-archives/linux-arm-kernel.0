From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 13 Dec 2010 19:07:32 -0800
Subject: [PATCH 1/5] OMAP4: hwmod data: Fix hwmod entries order
In-Reply-To: <1291937615-18571-2-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Fri, 10 Dec 2010 00:33:31 +0100")
References: <1291937615-18571-1-git-send-email-b-cousson@ti.com>
	<1291937615-18571-2-git-send-email-b-cousson@ti.com>
Message-ID: <87d3p52gsr.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit Cousson <b-cousson@ti.com> writes:

> The original OMAP4 hwmod data files is fully generated from HW
> database. But since the file is introduced incrementaly along
> with driver that uses the data, it has to be splitted by the driver
> owner and then re-merged by the maintainer.
> Because of the similarity of the data, git is completely lost
> during such merge and thus the data does not look like the original one
> at the end.
>
> Re-order properly the structures to stay in sync with original data set.
>
> Add a comment that does contain all the IPs that can have a hwmod, but
> do not have it in the file for the moment. It gives a good indication
> of the progress.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Govindraj.R <govindraj.raja@ti.com>
> Cc: Charulatha V <charu@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

My (mostly) blind git merges caused this problem in the first place.
Sorry.

Kevin
