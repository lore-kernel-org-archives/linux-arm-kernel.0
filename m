From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 22 Feb 2015 11:22:01 +0100
Subject: [PATCH 10/27] pxa27x_udc: Remove use of seq_printf return value
In-Reply-To: <2c9adbd539f0d96028b9dfe1caec0829c9feacf5.1424573328.git.joe@perches.com>
 (Joe Perches's message of "Sat, 21 Feb 2015 18:53:37 -0800")
References: <cover.1424573328.git.joe@perches.com>
 <2c9adbd539f0d96028b9dfe1caec0829c9feacf5.1424573328.git.joe@perches.com>
Message-ID: <87lhjq6yba.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joe Perches <joe@perches.com> writes:

> The seq_printf return value, because it's frequently misused,
> will eventually be converted to void.
>
> See: commit 1f33c41c03da ("seq_file: Rename seq_overflow() to
>      seq_has_overflowed() and make public")
>
> While there, simplify the error handler logic by returning
> immediately and remove the unnecessary labels.
>
> Signed-off-by: Joe Perches <joe@perches.com>
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
