From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 18 Feb 2010 14:38:42 +0800
Subject: [PATCH 1/2] arm/pxa: Enable check_scoop_reg() only if CONFIG_PM
	is set.
In-Reply-To: <1266356512-1269-1-git-send-email-stefan@datenfreihafen.org>
References: <1266356512-1269-1-git-send-email-stefan@datenfreihafen.org>
Message-ID: <f17812d71002172238n181d6bc2n9ffd22ca18348b2e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2010 at 5:41 AM, Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
> This function gets only called from scoop_suspend() and scoop_resume() which are
> only built in if we have CONFIG_PM set. Make it the same for check_scoop_reg().
>
> This fixes the following warning:
> arch/arm/common/scoop.c:143: warning: ?check_scoop_reg? defined but not used
>
> Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>

Applied to 'devel'.
