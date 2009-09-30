From: sam@ravnborg.org (Sam Ravnborg)
Date: Wed, 30 Sep 2009 23:31:18 +0200
Subject: [PATCH 1/2] arm: convert to use __HEAD and HEAD_TEXT macros.
In-Reply-To: <1254345935-15958-2-git-send-email-tabbott@ksplice.com>
References: <1254345935-15958-1-git-send-email-tabbott@ksplice.com>
	<1254345935-15958-2-git-send-email-tabbott@ksplice.com>
Message-ID: <20090930213118.GA15732@merkur.ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2009 at 05:25:34PM -0400, Tim Abbott wrote:
> This has the consequence of changing the section name used for head
> code from ".text.head" to ".head.text".  Since this commit changes all
> users in the architecture, this change should be harmless.
> 
> The .text.head output section is eliminated and the head text code is
> included at the start of the .init output section.
> 
> Signed-off-by: Tim Abbott <tabbott@ksplice.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
