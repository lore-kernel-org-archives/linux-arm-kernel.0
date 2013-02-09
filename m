From: joe@perches.com (Joe Perches)
Date: Fri, 08 Feb 2013 16:40:19 -0800
Subject: [PATCH] MAINTAINERS: add keyword "tegra" to Tegra section
In-Reply-To: <1360353891-24210-1-git-send-email-swarren@wwwdotorg.org>
References: <1360353891-24210-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1360370419.13487.8.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-02-08 at 13:04 -0700, Stephen Warren wrote:
> (?<!in)tegra

This doesn't work well.   It matches too many
words like integral.

I suggest

K:	(?:\btegra\b|\bTEGRA_)
