From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 06 Jan 2015 10:10:00 -0700
Subject: [PATCH 2/4] ARM: tegra: Move out nyan-generic parts out from
 the nyan-big DT
In-Reply-To: <1420540653-14816-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1420540653-14816-1-git-send-email-tomeu.vizoso@collabora.com>
 <1420540653-14816-3-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <54AC16E8.6060304@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2015 03:37 AM, Tomeu Vizoso wrote:
> In preparation for adding the DT for the nyan-blaze board.

"git format-patch -M" and/or "git format-patch -C" should make this 
patch a lot easier to review, since it'll show the patch as a file 
copy/rename rather than a full-file cut/paste.
