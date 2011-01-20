From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 20 Jan 2011 15:31:34 +0300
Subject: [PATCH] ARM: oprofile: Always allow backtraces
In-Reply-To: <1295470473-1095-1-git-send-email-kauppi@papupata.org>
References: <1295470473-1095-1-git-send-email-kauppi@papupata.org>
Message-ID: <4D382B26.9030801@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 19-01-2011 23:54, Ari Kauppi wrote:

> Always allow backtrace when using oprofile on ARM, even if a PMU
> isn't present.

> Restores functionality originally introduced in
> 1b7b56982fdcd9d85effd76f3928cf5d6eb26155 by Richard Purdie.

    You're lacking the commit summary specified in parens which Linus asked to 
add.

> Signed-off-by: Ari Kauppi<kauppi@papupata.org>
> Cc: Richard Purdie<rpurdie@rpsys.net>
> Cc: Will Deacon<will.deacon@arm.com>
> Cc: Matt Fleming<matt@console-pimps.org>

WBR, Sergei
