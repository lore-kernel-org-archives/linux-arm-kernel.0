From: gregkh@linuxfoundation.org (Greg KH)
Date: Sun, 2 Sep 2012 16:58:18 -0700
Subject: [PATCH v2] ARM: Build dtb files in all target
In-Reply-To: <20120902191424.GS28643@pengutronix.de>
References: <20120901152544.GB24085@n2100.arm.linux.org.uk>
 <20120901163235.GB748@mannheim-rule.local>
 <20120901182207.GC24085@n2100.arm.linux.org.uk>
 <20120901183859.GA958@mannheim-rule.local>
 <20120901201105.GD24085@n2100.arm.linux.org.uk>
 <1346594067.4958.7.camel@deadeye.wl.decadent.org.uk>
 <20120902170434.GA31141@n2100.arm.linux.org.uk>
 <1346606781.7787.25.camel@deadeye.wl.decadent.org.uk>
 <20120902180537.GB31141@n2100.arm.linux.org.uk>
 <20120902191424.GS28643@pengutronix.de>
Message-ID: <20120902235818.GB17057@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 02, 2012 at 09:14:24PM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> I try once to point out what I think is the misunderstanding in this
> thread.
> 
> The stable team is never the first team/person who picks up a patch. So
> Jason saying:
> 
> 	I've CC'd stable to see if they want to pick this up.
> 
> got something wrong (either by not knowing how stable works or by being
> unclear). That's why Greg send out his form letter.

Exactly correct.

If people wish to try to update stable_kernel_rules.txt to be a bit more
descriptive, please do so.  Personally, it seems detailed enough to me,
and no one who gets this all wrong, seems to have even read the file in
the first place, so odds are changing the file will not really help
much.

greg k-h



> Nevertheless you may still cc stable, but if you have the expectation
> that they pick it up without an other maintainer taking it first, you
> will be disappointed. If your mail's purpose is only to make the stable
> team aware of a patch that they might want to pick up later this is ok
> (and not covered by Documentation/stable_kernel_rules.txt).
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> --
> To unsubscribe from this list: send the line "unsubscribe stable" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
