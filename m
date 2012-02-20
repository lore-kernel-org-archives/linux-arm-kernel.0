From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 20 Feb 2012 18:33:04 +0000
Subject: [PATCH v7 5/8] davinci: dm644x: change vpfe capture structure
 variables for consistency
In-Reply-To: <1324475021-32509-6-git-send-email-manjunath.hadli@ti.com>
References: <1324475021-32509-1-git-send-email-manjunath.hadli@ti.com>
 <1324475021-32509-6-git-send-email-manjunath.hadli@ti.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317C7DB4@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manju,

On Wed, Dec 21, 2011 at 19:13:38, Hadli, Manjunath wrote:
> Add SoC and board prefixes to variable names so that it is
> consistent with the rest of the file.
> 
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> Acked-by: Sekhar Nori <nsekhar@ti.com>

Again the subject line was not following the conventions
currently in place. I am pretty sure they were in place
at the time you submitted the patch too. Please take care
next time onwards. For now, I have fixed it while committing.

While I was at it, I also modified the subject line to make
it less verbose. Here is what I committed:

    ARM: davinci: dm644x: fix inconsistent variable naming

    Add dm644x_ prefix to names of v4l2 variables in dm644x.c
    Add dm644xevm_ prefix to names of v4l2 variables in board-dm644x-evm.c.

    This makes the code consistent with rest of these files.

    Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
    Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
