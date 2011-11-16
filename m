From: linkinjeon@gmail.com (NamJae Jeon)
Date: Wed, 16 Nov 2011 14:31:00 +0900
Subject: [PATCH 4/4] mmc: Add mmc_host_<level> logging
In-Reply-To: <631c53d126feff0a99b61d9c9a00b308d2b638ee.1321398815.git.joe@perches.com>
References: <cover.1321398814.git.joe@perches.com>
 <631c53d126feff0a99b61d9c9a00b308d2b638ee.1321398815.git.joe@perches.com>
Message-ID: <CAKYAXd8od8mcahm3+tqzbgumf7Th47h8yGhoqfmmyNKujCK2ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/11/16 Joe Perches <joe@perches.com>:
> Centralize the pr_<level> uses of mmc_hostname into specific
> mmc_host_<level> calls to allow a flexible presentation style
> and shorten the code a bit.
>
> Add mmc_host_<level> macros.
> Convert the logging calls from:
> ? ? ? ?pr_<level>("%s: ...", mmc_hostname(foo)
> to:
> ? ? ? ?mmc_host_<level>(foo, ...)
>
> Add a couple of missing newlines.
> Convert bare printks to pr_cont where appropriate.
> Spelling/typo fix of initialiazed to initialized.
>
> Signed-off-by: Joe Perches <joe@perches.com>
Reviewed-by: NamJae Jeon <linkinjeon@gmail.com>

> ---
