From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 16:33:00 -0800
Subject: [PATCH 1/3] ipmi/bt-bmc: change compatible node to
 'aspeed,ast2400-ibt-bmc'
In-Reply-To: <2278270.0oJqDfoDd9@wuerfel>
References: <1478073426-3714-1-git-send-email-clg@kaod.org>
 <a886778e-a85e-758e-3a61-c4909652e39d@kaod.org>
 <c749ff0a-bc71-bc9f-0e8c-326db2cea0fb@acm.org>
 <2278270.0oJqDfoDd9@wuerfel>
Message-ID: <20161118003300.GA8578@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 05:09:12PM +0100, Arnd Bergmann wrote:
> On Tuesday, November 8, 2016 12:15:57 PM CET Corey Minyard wrote:
> > On 11/08/2016 09:52 AM, C?dric Le Goater wrote:
> > > O
> > snip
> > 
> > >>>> While we're modifying the binding, should we add a compat string for
> > >>>> the ast2500?
> > >>> Well, if the change in this patch is fine for all, may be we can add
> > >>> the ast2500 compat string in a followup patch ?
> > >> Sounds good to me.
> > > OK. So, how do we proceed with this patch ? Who would include it in its
> > > tree ?
> > 
> > I don't have anything for 4.9 at the moment.  Arnd, if you have 
> > something, can
> > you take this?  Otherwise I will.
> > 
> > And I guess I should add:
> > 
> > Acked-by: Corey Minyard <cminyard@mvista.com>
> 
> Thanks, I've added it to my todo folder.
> 
> Olof, if you do fixes before I do, please pick up this patch with
> Corey's Ack.

Done, applied to fixes.


-Olof
