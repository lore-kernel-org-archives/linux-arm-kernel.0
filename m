From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 5 Oct 2015 17:33:15 -0300
Subject: IMX6 serial fuckage
In-Reply-To: <20151005202718.GL21513@n2100.arm.linux.org.uk>
References: <20151005202718.GL21513@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5A_aZFJPMgSqDezi5KY3BJ-ywCwK7rUno=WqTXjmQOnCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 5, 2015 at 5:27 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Greg,
>
> Please revert this commit:
>
> commit 9e7b399d6528eac33a6fbfceb2b92af209c3454d
> Author: Eduardo Valentin <edubezval@gmail.com>
> Date:   Tue Aug 11 10:21:20 2015 -0700

Already reverted in Greg's tree:
https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git/commit/?h=tty-linus&id=0c727a42043f79db210cdde0366f9137b9c6bf5a

Should be available in 4.3-rc5.
