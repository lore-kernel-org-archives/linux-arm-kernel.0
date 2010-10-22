From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Oct 2010 08:49:18 +0100
Subject: [RFC PATCH] arm: msm: moved Kconfig machine entry into mach-msm
In-Reply-To: <1287686255-18674-1-git-send-email-dwalker@codeaurora.org>
References: <1287686255-18674-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <20101022074918.GA25606@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 21, 2010 at 11:37:35AM -0700, Daniel Walker wrote:
> Has anyone suggested this? It seems like it might reduce conflicts
> in the Kconfig file.

How?  The choice normally has one entry for each mach- directory.
You're still going to have 'source' for each mach- directory, so
the chances of conflicts are no different.

Plus it increases the file count, makes things more indirect, and
therefore harder to follow.
