From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 21 Sep 2014 19:02:07 +0200
Subject: [PATCH 7/8] arm: mach-pxa: Convert pr_warning to pr_warn
In-Reply-To: <70f104441791b08aadef9d7b72018161e9e773b0.1410632835.git.joe@perches.com>
 (Joe Perches's message of "Sat, 13 Sep 2014 11:31:18 -0700")
References: <cover.1410632834.git.joe@perches.com>
 <70f104441791b08aadef9d7b72018161e9e773b0.1410632835.git.joe@perches.com>
Message-ID: <871tr4nbzk.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joe Perches <joe@perches.com> writes:

> Use the more common pr_warn.
>
> Other miscellanea:
>
> o Coalesce formats
> o Realign arguments
>
> Signed-off-by: Joe Perches <joe@perches.com>

Applied to pxa/cleanup branch, thanks.

--
Robert
