From: samuel.thibault@ens-lyon.org (Samuel Thibault)
Date: Mon, 5 Jan 2015 19:00:05 +0100
Subject: [PATCHv5 2/2] INPUT: Introduce generic trigger/LED pairs to
 input LEDs
In-Reply-To: <20150105174205.GB35592@dtor-ws>
References: <20141226232116.GA5069@type> <20141226232310.GD5069@type>
 <20150104232838.GA14912@dtor-glaptop>
 <20150104234501.GJ25336@type.youpi.perso.aquilenet.fr>
 <20150105174205.GB35592@dtor-ws>
Message-ID: <20150105180005.GX3804@type.bordeaux.inria.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Torokhov, le Mon 05 Jan 2015 09:42:05 -0800, a ?crit :
> The input device's capabilities (with the exception of keymap) should
> not change after device registration. If uinput allows that we should
> fix it there.

Ah, I didn't notice the content of uinput_set_bit() there.  It seems to
be making sure that the device hasn't been created yet indeed.  All good
then.

Samuel
