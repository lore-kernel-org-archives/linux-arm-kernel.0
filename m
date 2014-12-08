From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 8 Dec 2014 21:04:15 +0100
Subject: [PATCH v3] i2c: rk3x: fix bug that cause measured high_ns
 doesn't meet I2C spec
In-Reply-To: <CAD=FV=WQypHthEDPGUqVX3kzfFBSdj4H+_QY_=WYA3R77H+WiQ@mail.gmail.com>
References: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
 <1418007589-3688-1-git-send-email-addy.ke@rock-chips.com>
 <20141208085202.GA13486@pengutronix.de>
 <CAD=FV=V=PDPiDhDmd+j8ePsF43EvuFP-LxKgMKo7ZRBzSMyOJA@mail.gmail.com>
 <20141208173432.GA5732@katana>
 <CAD=FV=WQypHthEDPGUqVX3kzfFBSdj4H+_QY_=WYA3R77H+WiQ@mail.gmail.com>
Message-ID: <20141208200415.GC13486@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Dec 08, 2014 at 10:53:44AM -0800, Doug Anderson wrote:
> So just to summarize for Addy, I think you're being asked to spin one more time.
> 
> 1. Update the patch description as per Uwe.  Fix other typos pointed out by him.
> 
> 2. Since you're spinning anyway, adjust "i2c" capitalization to "I2C".
> 
> 3. If you agree with Uwe, rename spec_max_data_hold_ns to
> spec_data_valid_ns.  If not, we should debate in a followup patch.
> 
> 4. If you think spec_data_hold_buffer_ns could be better represented
> in another way (should this be i2c-sda-falling-time-ns"?), please do
> so.  If not, we should debate in a followup patch.
Sounds all reasonable. I'd not address 3 and 4 in this patch, but do
this in separate one. (That's what I intended from the beginning, just
failed to point that out explicitly.)

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
