From: ben@decadent.org.uk (Ben Hutchings)
Date: Mon, 21 Jan 2013 01:51:13 +0000
Subject: [PATCH v4] sdma-imx: Add SDMA firmware for Freescale i.MX SOCs
In-Reply-To: <1358536921-29348-1-git-send-email-festevam@gmail.com>
References: <1358536921-29348-1-git-send-email-festevam@gmail.com>
Message-ID: <1358733073.24121.250.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-01-18 at 17:22 -0200, Fabio Estevam wrote:
[...]
> +CHOICE OF LAW; VENUE; LIMITATIONS.	You agree that the statutes and
> +laws of the United States and the State of Texas, USA, without regard
> +to conflicts of laws principles, will apply to all matters relating to
> +this Agreement or the Software, and you agree that any litigation will
> +be subject to the exclusive jurisdiction of the state or federal courts
> +in Texas, USA. You agree that regardless of any statute or law to the
> +contrary, any claim or cause of action arising out of or related to
> +this Agreement or the Software must be filed within one (1) year after
> +such claim or cause of action arose or be forever barred.
[...]

I also have no intention of going to Texas if Freescale thinks I did
something wrong with this firmware.  Can you ask their legal department
to have a look at some of the licences currently in linux-firmware.git,
because no-one else has insisted on stuff like this.

Most of the licences say that the firmware may be used and redistributed
for use with $vendor's products, with some or all of the restrictions:

- No modifications allowed
- No reverse-engineering
- No right to use $vendor's name for promotion

Plus the usual warranty disclaimer and requirement to keep the copyright
notice and licence text.

Ben.

-- 
Ben Hutchings
Q.  Which is the greater problem in the world today, ignorance or apathy?
A.  I don't know and I couldn't care less.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130121/c2be6108/attachment.sig>
