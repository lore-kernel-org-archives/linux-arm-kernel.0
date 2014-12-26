From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 26 Dec 2014 18:09:07 +0100
Subject: [PATCH] hx4700: regulator: declare full constraints
In-Reply-To: <1419377277-12727-1-git-send-email-martin.vajnar@gmail.com>
 (Martin Vajnar's message of "Wed, 24 Dec 2014 00:27:57 +0100")
References: <1419377277-12727-1-git-send-email-martin.vajnar@gmail.com>
Message-ID: <871tnm72z0.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Vajnar <martin.vajnar@gmail.com> writes:

> Since the removal of CONFIG_REGULATOR_DUMMY option, the touchscreen stopped
> working. This patch enables the "replacement" for REGULATOR_DUMMY and
> allows the touchscreen to work even though there is no regulator for "vcc".
>
>
> Signed-off-by: Martin Vajnar <martin.vajnar@gmail.com>

Queued up into pxa/for-next tree, thanks.

I took the liberty to add "Cc: stable at vger.kernel.org" to your commit as it
looks a regression to me. Feel free to add it next time.

Cheers.

--
Robert
