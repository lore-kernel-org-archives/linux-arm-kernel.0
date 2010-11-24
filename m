From: h-kanigeri2@ti.com (Kanigeri, Hari)
Date: Wed, 24 Nov 2010 07:14:36 -0600
Subject: [PATCH v4 4/5] OMAP: mailbox: send message in process context
In-Reply-To: <AANLkTimbXXmPu5KQtpxG6jTxaj18ad+Q5dHSPArEtXgr@mail.gmail.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
	<1290547617-16640-5-git-send-email-h-kanigeri2@ti.com>
	<AANLkTimbXXmPu5KQtpxG6jTxaj18ad+Q5dHSPArEtXgr@mail.gmail.com>
Message-ID: <AANLkTikaqT5wCOiDERgSh4EeOzuO16LZ-ydfSJhRLoXP@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 23, 2010 at 11:26 PM, Varadarajan, Charulatha <charu@ti.com> wrote:
> On Wed, Nov 24, 2010 at 02:56, Hari Kanigeri <h-kanigeri2@ti.com> wrote:
>> Schedule the Tasklet to send only when mailbox fifo is full and there are
>> pending messages in kifo, else send the message directly in the Process
>
> Typo -> kifo

Thanks :). My bad I I think overlooked Felipe's comment on my previous patch.

Thank you,
Best regards,
Hari Kanigeri
