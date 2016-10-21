From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 21 Oct 2016 16:34:10 -0400
Subject: [PATCH V4 09/10] trace, ras: add ARM processor error trace event
In-Reply-To: <1477071013-29563-10-git-send-email-tbaicar@codeaurora.org>
References: <1477071013-29563-1-git-send-email-tbaicar@codeaurora.org>
 <1477071013-29563-10-git-send-email-tbaicar@codeaurora.org>
Message-ID: <20161021163410.0a827eab@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Oct 2016 11:30:12 -0600
Tyler Baicar <tbaicar@codeaurora.org> wrote:

> Currently there are trace events for the various RAS
> errors with the exception of ARM processor type errors.
> Add a new trace event for such errors so that the user
> will know when they occur. These trace events are
> consistent with the ARM processor error section type
> defined in UEFI 2.6 spec section N.2.4.4.
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>

Tracing part looks fine to me.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
