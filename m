From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Aug 2015 14:37:54 +0200
Subject: [PATCH] pinctrl: atlas7: clear ugly branch statements for pull
 and drivestrength
In-Reply-To: <1438744934-15395-1-git-send-email-21cnbao@gmail.com>
References: <1438744934-15395-1-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdYtFSps1R-YgMFoekkW8osDVf+ujrnGLP47YBCcq2ZBzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 5, 2015 at 5:22 AM, Barry Song <21cnbao@gmail.com> wrote:

> From: Wei Chen <Wei.Chen@csr.com>
>
> To set/get atlas7 pull & drive strength, we use lots of if/else
> to check pad type. But except mask value or immediate value, all
> actions in these conditional branches are the same.
> So we use predefined pull info table and drive strength table
> to reduce these redundancy code.
>
> Signed-off-by: Wei Chen <Wei.Chen@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Patch applied.

Yours,
Linus Walleij
