From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 17 Oct 2016 07:41:02 +0100
Subject: [STLinux Kernel] [PATCH 28/57] [media] c8sectpfe: don't break
 long lines
In-Reply-To: <b82cb64c6328c81104143d8a509d4ab6f77873a2.1476475771.git.mchehab@s-opensource.com>
References: <cover.1476475770.git.mchehab@s-opensource.com>
 <b82cb64c6328c81104143d8a509d4ab6f77873a2.1476475771.git.mchehab@s-opensource.com>
Message-ID: <20161017064102.GA8788@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Oct 2016, Mauro Carvalho Chehab wrote:

> Due to the 80-cols checkpatch warnings, several strings
> were broken into multiple lines. This is not considered
> a good practice anymore, as it makes harder to grep for
> strings at the source code. So, join those continuation
> lines.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> ---
>  drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c | 15 +++++----------

Acked-by: Peter Griffin <peter.griffin@linaro.org>
