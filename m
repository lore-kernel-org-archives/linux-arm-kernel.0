From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 16 Jan 2012 18:55:04 -0200
Subject: [PATCH] ARM: clock-mx28: Fix end of loop condition
In-Reply-To: <201201162152.59997.marek.vasut@gmail.com>
References: <1326740477-21576-1-git-send-email-fabio.estevam@freescale.com>
 <CAOMZO5B1ABUr1bqW8f_YLjtE46DBkFt1HocZVziv0barHq1TJg@mail.gmail.com>
 <201201162152.59997.marek.vasut@gmail.com>
Message-ID: <CAOMZO5BQ1BCdf2HkUXG55dtfUk-4sSZE6TqnZ+gO9zwXVWt5vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 6:52 PM, Marek Vasut <marek.vasut@gmail.com> wrote:

> I see ... ignore my previous comment ;-)

Sorry for the noise of my previous patch. I think this issue can be
solved by just increasing the timeout value.

I will make more tests to confirm and post a new patch.

Regards,

Fabio Estevam
