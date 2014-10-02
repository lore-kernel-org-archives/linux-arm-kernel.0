From: j.uzycki@elproma.com.pl (Janusz Uzycki)
Date: Thu,  2 Oct 2014 20:11:35 +0200
Subject: [PATCH RESEND] serial: mxs-auart: add sysrq support
In-Reply-To: <20140929014129.GA8687@kroah.com>
References: <20140929014129.GA8687@kroah.com>
Message-ID: <1412273496-10610-1-git-send-email-j.uzycki@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> So I'm deleting all of these now, please resend the latest
> versions you have, with properly versioning
> and order information.
Sure. I've just learnt about RFC header.

[PATCH RESEND] serial: mxs-auart: add sysrq support
It is extracted from my previous patchset
as independent from others.
The patch is resent as ready to apply.

I resend it again because last time
in conver letter I swapped subject with
in-reply-to and the patch could be omited.

Janusz Uzycki (1):
  serial: mxs-auart: add sysrq support

 drivers/tty/serial/mxs-auart.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
1.7.11.3
