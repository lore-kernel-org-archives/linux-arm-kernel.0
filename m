From: balbi@ti.com (Felipe Balbi)
Date: Tue, 16 Jun 2015 17:08:29 -0500
Subject: [PATCH 2/2] cpufreq: dt: allow driver to boot automatically
In-Reply-To: <CAJZ5v0hO+Rbcyq8Gcpecdw9rGW1Qdhrmj6X6TVtRpLOxQKW+=g@mail.gmail.com>
References: <1431115050-23693-1-git-send-email-balbi@ti.com>
 <1431115050-23693-2-git-send-email-balbi@ti.com>
 <20150616214032.GA4313@saruman.tx.rr.com>
 <CAJZ5v0hO+Rbcyq8Gcpecdw9rGW1Qdhrmj6X6TVtRpLOxQKW+=g@mail.gmail.com>
Message-ID: <20150616220829.GB4313@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 12:04:07AM +0200, Rafael J. Wysocki wrote:
> On Tue, Jun 16, 2015 at 11:40 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Fri, May 08, 2015 at 02:57:30PM -0500, Felipe Balbi wrote:
> >> by adding the missing MODULE_ALIAS(), cpufreq-dt
> >> can be autoloaded by udev/systemd.
> >>
> >> Signed-off-by: Felipe Balbi <balbi@ti.com>
> >
> > looks like this wasn't applied anywhere. Viresh, can you apply this
> > patch please ?
> 
> I've overlooked it, sorry about that.  Applied now, thanks!

Thanks Rafael.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150616/de9514a8/attachment-0001.sig>
