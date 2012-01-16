From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 16 Jan 2012 22:07:00 +0100
Subject: [PATCH] ARM: clock-mx28: Fix end of loop condition
In-Reply-To: <CAOMZO5BQ1BCdf2HkUXG55dtfUk-4sSZE6TqnZ+gO9zwXVWt5vw@mail.gmail.com>
References: <1326740477-21576-1-git-send-email-fabio.estevam@freescale.com>
 <CAOMZO5B1ABUr1bqW8f_YLjtE46DBkFt1HocZVziv0barHq1TJg@mail.gmail.com>
 <201201162152.59997.marek.vasut@gmail.com>
 <CAOMZO5BQ1BCdf2HkUXG55dtfUk-4sSZE6TqnZ+gO9zwXVWt5vw@mail.gmail.com>
Message-ID: <20120116210700.GA5823@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 06:55:04PM -0200, Fabio Estevam wrote:
> On Mon, Jan 16, 2012 at 6:52 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> 
> > I see ... ignore my previous comment ;-)
> 
> Sorry for the noise of my previous patch. I think this issue can be
> solved by just increasing the timeout value.
> 
> I will make more tests to confirm and post a new patch.

Please make it proper and use some real timeout value (measured in us) instead
of this random loop counter.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120116/c9645063/attachment.sig>
