From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 29 Mar 2016 11:14:38 -0300
Subject: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
In-Reply-To: <1459241739.2565.9.camel@pengutronix.de>
References: <m3h9fuk7ik.fsf@t19.piap.pl>
 <CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
 <CAOMZO5B8Lzn-E4YOeYxVtN5PN11aOvZHn4eU0ixkdV8CO8+xYw@mail.gmail.com>
 <CAJ+vNU2Sg1ZKBsGcQswrJZyTJ1WBEZor3ZqpoYUT7i9FKjEAog@mail.gmail.com>
 <CAOMZO5DO9G18=_YSri3a+UiYbLwN6AMG4asUXbT03mpbU3hHrw@mail.gmail.com>
 <CAJ+vNU1_YqvWQkmuDB7r8z77iZJS6pP4Mr+j9yW4sFLAeJXQDw@mail.gmail.com>
 <CAOMZO5A2osG3=mTaCayYfMokUj-vT+Udq9ckq45b1yaUP9Tn3g@mail.gmail.com>
 <CAJ+vNU2ST=XG5H04-OCwpHgcvkoXOQw8F3MjXhJmWhBUbxWE-g@mail.gmail.com>
 <1459241739.2565.9.camel@pengutronix.de>
Message-ID: <CAOMZO5Cisx9xv9hCxzYK2U-MdVCdbVMYGY2y4PVoVReWjwE8=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 5:55 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

> I would suspect that most boards specify the reset polarity the wrong
> way around. Fixing this without breaking DT stability is hard. OTOH we

It is not hard if we just revert the buggy commit.

> could just argue that the system description in DT is wrong and needs to
> be fixed.

Sure, this would be a nice thing to do as well.
