From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 29 Aug 2012 00:20:55 -0700
Subject: [PATCH] ARM: Build dtb files in all target
In-Reply-To: <1346218523-15958-1-git-send-email-andrew@lunn.ch>
References: <1346218523-15958-1-git-send-email-andrew@lunn.ch>
Message-ID: <503DC2D7.2080107@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/28/2012 10:35 PM, Andrew Lunn wrote:
> Tools like kisskb are good at finding build regressions in the kernel
> sources. However, regressions in the DT desscriptions are not found,
> because generally these build systems don't build the DT binary blobs.
>
> Extend the ARM all target to build all enabled DTB files.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

You should probably put a star (*) next to the dtbs info in the help
text too.

Have you tried this in a clean tree? Also, should this only be default
true if USE_OF is true?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
