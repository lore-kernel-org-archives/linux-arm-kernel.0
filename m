From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 3 Aug 2012 13:48:12 -0300
Subject: [PATCH] MXS: Fix mxs_defconfig MMAP_MIN_ADDR
In-Reply-To: <CAOMZO5DZui3x554WcHsseSfXDgYeaq1va-QzVy1CQajE3M3=kQ@mail.gmail.com>
References: <1344009354-13249-1-git-send-email-marex@denx.de>
 <CAOMZO5DZui3x554WcHsseSfXDgYeaq1va-QzVy1CQajE3M3=kQ@mail.gmail.com>
Message-ID: <CAOMZO5Cg_YvJSCdnxWkW3K5Wk=o0DLa9kefgeeuQYpRWVMCPkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 3, 2012 at 1:46 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Marek,
>
> On Fri, Aug 3, 2012 at 12:55 PM, Marek Vasut <marex@denx.de> wrote:
>> Initially reported by Detlev Zundel <dzu@denx.de>, this caused breakage
>> when "su - testuser" was called. "testuser" being a regular user account,
>> the command ended with SIGKILL.

Also, please point to the commit that introduced such breakage.

Thanks,

Fabio Estevam
