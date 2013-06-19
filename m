From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 19 Jun 2013 11:39:59 +0800
Subject: [RFC PATCH v1 6/6] USB: EHCI: support running URB giveback in
 tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306181252320.1157-100000@iolanthe.rowland.org>
References: <1371567833-9077-7-git-send-email-ming.lei@canonical.com>
 <Pine.LNX.4.44L0.1306181252320.1157-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVMZ6V2gMJmORxTwq+qwbuN7FdKK4Q3VwJPq8Pj9PctOZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 12:55 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 18 Jun 2013, Ming Lei wrote:
>
>> Both 4 transfers can work well on EHCI HCD after switching to run
>
> "Both 4 transfers"?  The word "both" applies when there are two items,
> not more than two.  And what are the four transfers you are referring
> to?  Do you mean all four transfer _types_?

Yes, I mean the four transfer types, and "Both 4 transfers" should have
been "all four transfer types", will fix it in v2.


Thanks,
--
Ming Lei
