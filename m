From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 16 Oct 2012 01:08:57 -0300
Subject: [PATCH 1/2] ARM: mx27_3ds: Reserve memory for camera usage
In-Reply-To: <20121010075222.GN27665@pengutronix.de>
References: <1349839770-13848-1-git-send-email-festevam@gmail.com>
 <20121010075222.GN27665@pengutronix.de>
Message-ID: <CAOMZO5DqJuernaHk-4KO_v=8vPCnrpqCZ-uZ2nrhtFcKo9xObA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2012 at 4:52 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, Oct 10, 2012 at 12:29:29AM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Reserve dedicated memory block for camera usage.
>
> Why not use CMA?

Sorry, not familiar with CMA. Could you please point to some board
file/driver that makes use of it?

Regards,

Fabio Estevam
