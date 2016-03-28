From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Mon, 28 Mar 2016 10:01:18 +0000
Subject: [PATCH] usb: host: xhci-plat: Make enum xhci_plat_type start at a
 non zero value
In-Reply-To: <87d1qf80oc.fsf@ti.com>
References: <1458917188-28452-1-git-send-email-peter.griffin@linaro.org>
 <87mvpm8pfl.fsf@ti.com> <87mvpmlc5e.fsf@free-electrons.com>
 <87io0a8nbd.fsf@ti.com>
 <20160326091050.GA7793@griffinp-ThinkPad-X1-Carbon-2nd>
 <SG2PR06MB09190267848198365A7783A3D8860@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <87d1qf80oc.fsf@ti.com>
Message-ID: <SG2PR06MB09190A92BBFE5E530ADF1BD2D8860@SG2PR06MB0919.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Sent: Monday, March 28, 2016 5:30 PM
> 
> Hi,
> 
> Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com> writes:
> >> > ps: there might be bugs there, but it's a holiday and I really shouldn't
> >> > be spending time on this right now ;-)
> >>
> >> I'm also off on holiday now until Sunday 10th April... yay :-)
> >> >
> >> > Anyway, have fun testing. Let me know if it doesn't work.
> >>
> >> I only have access to STi platforms which were broken by this change.
> >> Not any of the platforms which rely on the functionality which
> >> was introduced (although I can't see any reason why your patch wouldn't work).
> >>
> >> Maybe Yoshihiro (on CC) could test this on the Renesas platforms and confirm?
> >
> > Thank you for sending the email to me on CC.
> >
> > I tested Felipe's patch on Renesas platfroms (R-Car Gen2 and Gen3) and
> > I fixed the patch like the following.
> >
> > However, my fixes patch might need to clean the code up more.
> >
> > Changes from Felipe's patch:
> > - Change function names of xhci_rcar_init_quirk() to xhci_rcar_setup_quirk()
> 
> I'm not sure renaming that function fits on the same patch ;-) Sounds
> like it should be a separate patch altogether. I'll work on this
> tomorrow if it's okay for you guys to test on your respective platforms :-)

Thank you for the comment!
I also think it should be separate patch ;)
Also I'm okay to test your patch(es) on my platforms :)

Best regards,
Yoshihiro Shimoda

> --
> balbi
