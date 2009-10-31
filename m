From: linuxzsc@gmail.com (Richard Zhao)
Date: Sat, 31 Oct 2009 10:47:58 +0800
Subject: [PATCH V1 1/3] i2c: imx: check busy bit when START/STOP
In-Reply-To: <20091030004025.GG13398@fluff.org.uk>
References: <1255772784-11387-1-git-send-email-linuxzsc@gmail.com>
	<20091030004025.GG13398@fluff.org.uk>
Message-ID: <4e090d470910301947y2cd4e95x88f500c6c008d97d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2009 at 8:40 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> Does anyone have any comments on these, or shall I look at merging
> them as fixes?
>
> --
> Ben (ben at fluff.org, http://www.fluff.org/)
>
> ?'a smiley only costs 4 bytes'
>

Thanks, Ben! I've test these patch on imx31 pdk and imx51 pdk.

  Richard
