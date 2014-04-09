From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 9 Apr 2014 09:41:02 +0100
Subject: [PATCH] arm64: Add user_debug command line option
In-Reply-To: <1397007908-17993-1-git-send-email-lauraa@codeaurora.org>
References: <1397007908-17993-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140409084101.GC13737@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 02:45:08AM +0100, Laura Abbott wrote:
> arm had a useful command line option to print out debug
> information on user signals. This is somewhat like a more verbose
> version of show_unhandled_signals. Add the user_debug command line
> option to print out more information in a similar manner to
> arm.

Is this because you want to print information for handled signals as
well? What is the use case? (there are alternatives like ptrace as
well).

-- 
Catalin
