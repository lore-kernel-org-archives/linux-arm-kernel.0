From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 24 Nov 2014 14:12:19 +0100
Subject: [PATCH v4 1/2] of: Rename "poweroff-source" property to
 "system-power-controller"
In-Reply-To: <CABgxDo+t1DUMHwWygibR-w=FL458N6k0G68HM2M7R76gJugyVg@mail.gmail.com>
References: <1415885699-1465-1-git-send-email-user@radxa>
 <CABgxDoLA=QL6vzU-v1w4vMZ3qhorjRdYOWFFMrjJE6xvZ7QO3g@mail.gmail.com>
 <CABgxDo+t1DUMHwWygibR-w=FL458N6k0G68HM2M7R76gJugyVg@mail.gmail.com>
Message-ID: <1651776.uhbV5BHLKC@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 24. November 2014, 14:01:02 schrieb Romain Perier:
> 2014-11-24 13:58 GMT+01:00 Romain Perier <romain.perier@gmail.com>:
> > So I need to resend this patch which would only introduce an helper
> > function which checks for "system-power-controller" property (it would
> > also have a new commit message).
> > As you suggested, this helper might be named
> > "of_device_is_system_power_controller" ?
> 
> I mean, the backward compatibility can be handled directly from the
> device driver which would use the new property, no ?

yep, that is what Grant asked for ... to have drivers that need backward-
compatibility (like with the "ti,"-prefix) to do this themselfs.


Heiko
