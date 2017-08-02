From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 2 Aug 2017 22:07:03 +0200
Subject: i.mx7: Changing linux,usable-memory causes BUG: Bad Page
In-Reply-To: <CAN1Oqpw835L3Rc-J59_qSJ3toUWH8TD00r=ZcN6quvcnE8mnHQ@mail.gmail.com>
References: <CAN1Oqpw835L3Rc-J59_qSJ3toUWH8TD00r=ZcN6quvcnE8mnHQ@mail.gmail.com>
Message-ID: <20170802200703.rnr4ucjy5c7dnhuf@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ryan,

On Wed, Aug 02, 2017 at 09:11:14AM -0700, Ryan Schaefer wrote:
> I am using an i.mx7d based board, and attempting to reserve the lower
> 2MB of memory for the M4 co-processor.

Linux expects TAM starting at a 128 MiB boundary in some places. So,
does it work if you reserve 128 MiB for the M4?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
