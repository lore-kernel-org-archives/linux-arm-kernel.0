From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 2 May 2014 15:03:33 -0400
Subject: [PATCH v8 1/8] ftrace: make CALLER_ADDRx macros more generic
In-Reply-To: <20140502181348.GD14645@arm.com>
References: <1394862048-28758-1-git-send-email-takahiro.akashi@linaro.org>
 <1398851676-16389-1-git-send-email-takahiro.akashi@linaro.org>
 <1398851676-16389-2-git-send-email-takahiro.akashi@linaro.org>
 <20140502181348.GD14645@arm.com>
Message-ID: <20140502150333.4af8b89c@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 May 2014 19:13:48 +0100
Will Deacon <will.deacon@arm.com> wrote:

> This one looks a bit too widespread to be merged via the arm64 tree. I
> wonder if the ftrace maintainers would consider taking it as a cleanup?

Oh, and I can take the patch if you feel uncomfortable with taking
something so spread out. As it deals with ftrace I probably can get
away with a cross the board arch change to it.

-- Steve
