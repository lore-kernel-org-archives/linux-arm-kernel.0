From: kaloz@openwrt.org (Imre Kaloz)
Date: Fri, 09 Jan 2015 13:51:09 +0100
Subject: [PATCH] mvebu: add Linksys WRT1900AC (Mamba) support
In-Reply-To: <54AFCDA3.1030601@free-electrons.com>
References: <1420806710-27619-1-git-send-email-kaloz@openwrt.org>
 <54AFCDA3.1030601@free-electrons.com>
Message-ID: <op.xr64njf92s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 09 Jan 2015 13:46:27 +0100, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

Hi Gregory,

<snip>

>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>
> We are moving to a dual license GPL/X11:
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/380065
>
> Could you consider to use it too?
> The file you based on will be converted, all the author of this
> file already have given their acked-by.

I'm aware of that, but Linus' tree still has the old license text so I didn't change it here. If it would be up to me, it would be simply ISC.

> In meantime, I will review the content of your patch.

Thank you. I'll incorporate whatever needs to be fixed with the license change in v2.


Imre
