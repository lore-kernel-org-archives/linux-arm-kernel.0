From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 05 May 2014 14:40:05 +0200
Subject: [PATCH 2/2] Add 32-bit accesses
In-Reply-To: <20140505120801.GA16461@amd.pavel.ucw.cz>
References: <20140426203131.GA21832@amd.pavel.ucw.cz>
 <6bf951b6-51e7-4b90-b054-9ba5b6e93874@email.android.com>
 <20140427122510.GB12901@amd.pavel.ucw.cz>
 <1398716449.836.4.camel@dinh-ubuntu>
 <20140428211505.GA28242@amd.pavel.ucw.cz>
 <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com>
 <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com>
 <20140430215359.GA15148@amd.pavel.ucw.cz>
 <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com>
 <20140502084851.GA5730@amd.pavel.ucw.cz>
 <20140505120801.GA16461@amd.pavel.ucw.cz>
Message-ID: <536786A5.7070002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2014 02:08 PM, Pavel Machek wrote:
> 
> Add helpers for 32-bit accesses and replace open-coded 32-bit access
> with calls to helpers.

In general looks good, but please add the modifications from the
platform file, where you add the 32 callbacks to this patch. Please
don't forget to modify the pci driver, too.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
