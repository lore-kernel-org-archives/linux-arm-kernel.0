From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 8 Sep 2016 18:10:51 +0000
Subject: [RFC 1/7] Make Hi3620 explicit, remove wildcards
In-Reply-To: <a9b0bd8f-6ccb-6b39-a961-c5b5aca9a9f1@gmail.com>
References: <20160908172346.27506-1-netz.kernel@gmail.com>
 <20160908174756.GC12916@io.lakedaemon.net>
 <a9b0bd8f-6ccb-6b39-a961-c5b5aca9a9f1@gmail.com>
Message-ID: <20160908181051.GF12916@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 12:55:50PM -0500, Marty Plummer wrote:
> On 09/08/2016 12:47 PM, Jason Cooper wrote:
> > - Please Cc Andrew, Russell and myself on future series.
> > 
> > Personally, I do that at the 'send-email' stage instead of
> > 'format-patch'.  But whichever you prefer.  Don't be shy about Cc'ing.
> > We all are accustomed to handling lots of email.  It makes it easier for
> > us to spot stuff we are actively involved in. :-)
> > 
> Alrighty, I sorta realized this issue right after I sent, will do in
> future instances. Also, you say at 'send-email' instead of
> 'format-patch'; I take it there is a way to do the latter? I'm not aware
> of it :)

Both git send-email and git format-patch take --to, --cc, --bcc as
arguments.  I prefer to do all of the email addressing with send-email
instead of while doing format-patch.  But it's personal preference,
that's why the options are in both.

thx,

Jason.
